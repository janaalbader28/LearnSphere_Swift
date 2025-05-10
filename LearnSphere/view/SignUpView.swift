import SwiftUI

struct SignUpPage: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var birthday: Date = Date()
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var skillLevel: String = "Beginner"
    @State private var showAlert = false
    @State private var selectedSkill = "Select Level..."
    @State private var alertMessage: String = ""
    @State private var showDatePicker = false
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
                
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10)
                Spacer()
            }
            .padding()

            VStack(alignment: .leading, spacing: 20) {
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
                        .background(Circle().fill(Color.blue.opacity(0.1)))}}

                Text("Username:")
                    .font(.headline)
                TextField("Enter your username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Password:")
                    .font(.headline)
                SecureField("Password (8+ characters)", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())


                
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
            
            
            
            Button("Sign Up") {
                if validateInputs() {
                    if UserDatabase.shared.checkEmailInDatabase(email) {
                        alertMessage = "An account with this email already exists."
                        showAlert = true
                    } else if UserDatabase.shared.signUp(
                        username: username,
                        password: password,
                        fullName: fullName,
                        email: email,
                        birthday: birthday,
                        skillLevel: selectedSkill
                    ) {
                        alertMessage = "You have signed up successfully!"
                        showAlert = true

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    } else {
                        alertMessage = "Username already exists or failed to sign up."
                        showAlert = true
                    }
                }
            }



            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(.horizontal)

            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Sign Up"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }

         

            Spacer()
        }
        
        .background(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            loadUserProfile()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showDatePicker) {
            GraphicalDatePicker(selectedDate: $birthday)
        }
    }

    // Input validation function
    private func validateInputs() -> Bool {
        if username.isEmpty || password.isEmpty || fullName.isEmpty || email.isEmpty || selectedSkill == "Select Level..." {
            alertMessage = "All fields are required."
            showAlert = true
            return false
        }

        if password.count < 8 {
            alertMessage = "Password must be at least 8 characters."
            showAlert = true
            return false
        }

        if !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return false
        }

        return true
    }


    // Email validation function
    private func isValidEmail(_ email: String) -> Bool {
        // Simple regex for email validation
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    func loadUserProfile() {
        if let userProfile = UserDatabase.shared.getUserProfile(username: username) {
            fullName = userProfile.fullName
            email = userProfile.email
            birthday = userProfile.birthday
            username = userProfile.username
            selectedSkill = userProfile.skillLevel ?? "Select Level..."
        }
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
