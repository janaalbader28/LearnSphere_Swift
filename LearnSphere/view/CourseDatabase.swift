
import SQLite
import Foundation
import UIKit


class CourseDatabase {
    static let shared = CourseDatabase()
    
    private var db: Connection?
    private let coursesTable = Table("courses")
    
    // Columns
    private let id = Expression<Int64>("id")
    private let title = Expression<String>("title")
    private let info = Expression<String>("info")
    private let url = Expression<String>("url")
    private let location = Expression<String>("location")
    private let date = Expression<String>("date")
    private let type = Expression<String>("type")
    private let imagePath = Expression<String>("imagePath")

    
    private init() {
        setupDatabase()
    }
    private func setupDatabase() {
        do {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let databasePath = documentDirectory.appendingPathComponent("courses.sqlite3").path
            
            db = try Connection(databasePath)
            try db?.run(coursesTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(title)
                t.column(info)
                t.column(url)
                t.column(location)
                t.column(date)
                t.column(type)
                t.column(imagePath)
            })
        } catch {
            print("Database setup error: \(error)")
        }
    }
    func updateCourse(id: Int64, title: String, info: String, url: String, location: String, date: Date, imagePath: String) {
        let course = coursesTable.filter(self.id == id)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)

        do {
            try db?.run(course.update(
                self.title <- title,
                self.info  <- info,
                self.url   <- url,
                self.location <- location,
                self.date  <- dateString,
                self.imagePath <- imagePath
            ))
            print("Course updated successfully.")
        } catch {
            print("Update failed: \(error)")
        }
    }

    
    func insertCourse(title: String, info: String, url: String, location: String, date: Date, type: String, imagePath: String) {
        print("Attempting to insert course with title: \(title)")
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)

            try db?.run(coursesTable.insert(
                self.title <- title,
                self.info <- info,
                self.url <- url,
                self.location <- location,
                self.date <- dateString,
                self.type <- type,
                self.imagePath <- imagePath
            ))

            print("Course inserted successfully.")
        } catch {
            print("Insert failed: \(error)")
        }
    }


    
    func saveImageToDocuments(_ image: UIImage, fileName: String) -> String? {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = directory.appendingPathComponent(fileName)
            
            do {
                try data.write(to: fileURL)
                return fileURL.path
            } catch {
                print("Saving image failed: \(error)")
            }
        }
        return nil
    }


    func fetchCourses(byType type: String) -> [Course] {
        var results: [Course] = []

        do {
            let query = coursesTable.filter(self.type == type)
            for row in try db!.prepare(query) {
                let course = Course(
                    title: row[self.title],
                    info: row[self.info],
                    date: row[self.date],
                    location: row[self.location],
                    imagePath: row[self.imagePath],
                    url: row[self.url],
                    type: row[self.type],
                    id: row[self.id]
                )
                results.append(course)
            }
        } catch {
            print("Fetch error: \(error)")
        }

        return results
    }

    
    func deleteCourse(courseId: Int64) {
        do {
            let course = coursesTable.filter(id == courseId)
            try db?.run(course.delete())
            print("Course deleted successfully.")
        } catch {
            print("Delete failed: \(error)")
        }
    }

}
