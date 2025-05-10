import SwiftUI

struct UpdateProfile: View {
    @Environment(\.presentationMode) var presentationMode

    @State var username: String

    @State private var showDatePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var birthday: Date = Date()
    @State private var selectedSkill = "Select Level..."
    @State private var originalEmail: String = ""
    let skillLevels = ["Select Level...", "Beginner", "Intermediate", "Advanced"]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Circle().stroke(Color.black, lineWidth: 1))
                }

                Text("Update Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10)

                Spacer()
            }
            .padding()

            // Form
            Group {
                Text("Full Name:")
                    .font(.headline)
                TextField("Enter your full name", text: $fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Email:")
                    .font(.headline)
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Birthday:")
                    .font(.headline)
                HStack {
                    Text(formatDate(birthday))
                        .font(.body)
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        self.showDatePicker.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                            .padding(8)
                            .background(Circle().fill(Color.blue.opacity(0.1)))
                    }
                }

                Text("Username:")
                    .font(.headline)
                Text(username)
                    .font(.body)
                    .foregroundColor(.gray)

                Text("Skill Level:")
                    .font(.headline)
                Picker("Select your level", selection: $selectedSkill) {
                    ForEach(skillLevels, id: \.self) { level in
                        Text(level)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

            // Buttons
            HStack(spacing: 40) {
                Button("Save") {
                    if validateInputs() {
                        let success = UserDatabase.shared.updateUserProfile(
                            username: username,
                            fullName: fullName,
                            email: email,
                            birthday: birthday,
                            skillLevel: selectedSkill
                        )
                        alertMessage = success ? "Profile updated successfully!" : "Failed to update profile."
                        showAlert = true
                    } else {
                        showAlert = true
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(15)

                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(15)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top)
        .background(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            if let userProfile = UserDatabase.shared.getUserProfile(username: username) {
                fullName = userProfile.fullName
                email = userProfile.email
                birthday = userProfile.birthday
                selectedSkill = userProfile.skillLevel ?? "Select Level..."
                originalEmail = userProfile.email
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showDatePicker) {
            GraphicalDatePicker(selectedDate: $birthday)
        }
    }

    // MARK: - Validation
    func validateInputs() -> Bool {
        if fullName.isEmpty || email.isEmpty {
            alertMessage = "All fields are required."
            return false
        }

        if !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            return false
        }

        if selectedSkill == "Select Level..." {
            alertMessage = "Please select a skill level."
            return false
        }

       
        if UserDatabase.shared.checkEmailInDatabase(email) && email != originalEmail {
            alertMessage = "This email is already in use by another account."
            return false
        }

        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        let regex = #"^\S+@\S+\.\S+$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
