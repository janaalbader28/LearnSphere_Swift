import SQLite
import Foundation

class UserDatabase {
    static let shared = UserDatabase()
    
    private var db: Connection?
    private let usersTable = Table("users")
    
    // Columns
    private let id = Expression<Int64>("id")
    private let username = Expression<String>("username")
    private let password = Expression<String>("password")
    private let fullName = Expression<String>("fullName")
    private let email = Expression<String>("email")
    private let birthday = Expression<Date>("birthday")
    private let skillLevel = Expression<String>("skillLevel")

    private init() {
        setupDatabase()
    }

    private func setupDatabase() {
        do {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let databasePath = documentDirectory.appendingPathComponent("users.sqlite3").path
            
            db = try Connection(databasePath)
            try db?.run(usersTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(username, unique: true)
                t.column(password)
                t.column(fullName)
                t.column(email, unique: true)
                t.column(birthday)
                t.column(skillLevel)
            })
        } catch {
            print("Database setup error: \(error)")
        }
    }
    
    func checkEmailInDatabase(_ email: String) -> Bool {
        let userDatabase = UserDatabase.shared

        do {
            let query = userDatabase.usersTable.filter(userDatabase.email == email)
            if let userRow = try userDatabase.db?.pluck(query) {
                return userRow[userDatabase.email] == email // Email matches
            }
        } catch {
            print("Email check error: \(error)")
        }

        return false // Email not found
    }


    
    
    func signUp(username: String, password: String, fullName: String, email: String, birthday: Date, skillLevel: String) -> Bool {
        do {
            let insert = usersTable.insert(self.username <- username, self.password <- password, self.fullName <- fullName, self.email <- email, self.birthday <- birthday, self.skillLevel <- skillLevel)
            
            try db?.run(insert)
            return true
        } catch {
            print("Sign up error: \(error)")
            return false
        }
    }

    func login(username: String, password: String) -> Bool {
        do {
            let query = usersTable.filter(self.username == username && self.password == password)
            if let _ = try db?.pluck(query) {
                return true
            }
        } catch {
            print("Login error: \(error)")
        }
        return false
    }

    func getUserProfile(username: String) -> User? {
        do {
            let query = usersTable.filter(self.username == username)
            if let userRow = try db?.pluck(query) {
                return User(
                    fullName: userRow[self.fullName],
                    email: userRow[self.email],
                    birthday: userRow[self.birthday],
                    username: userRow[self.username],
                    skillLevel: userRow[self.skillLevel]
                )
            }
        } catch {
            print("Fetch user profile error: \(error)")
        }
        return nil
    }

    func updateUserProfile(username: String, fullName: String, email: String, birthday: Date, skillLevel: String) -> Bool {
        do {
            let user = usersTable.filter(self.username == username)
            let update = user.update([
                self.fullName <- fullName,
                self.email <- email,
                self.birthday <- birthday,
                self.username <- username,   // Ensure username is updated here too
                self.skillLevel <- skillLevel // Add skillLevel to the update
            ])
            let updatedCount = try db?.run(update)
            return updatedCount != 0 // Returns true if one or more rows were updated
        } catch {
            print("Update user profile error: \(error)")
            return false
        }
    }



    func deleteUser(username: String) -> Bool {
        do {
            let user = usersTable.filter(self.username == username)
            if try db?.run(user.delete()) != 0 {
                return true
            }
        } catch {
            print("Delete user error: \(error)")
        }
        return false
    }
    
    
}
