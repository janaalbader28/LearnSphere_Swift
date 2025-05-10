import SwiftUI

struct ForgotPassword: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle().stroke(Color.black, lineWidth: 1))
                    }
                    .frame(width: 35, height: 35)
                    .padding(.leading, 20)

                    Spacer()
                }
                .frame(height: 60)

                Image("pass3")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.top, 10)

                Text("Forgot your password?")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.black)

                Text("Enter your email below to receive\na new password")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    .foregroundColor(.black)

                TextField("Enter Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(.horizontal, 20)

                Button("Send Password") {
                    if isValidEmail(email) {
                        // Check if the email exists in the database
                        if UserDatabase.shared.checkEmailInDatabase(email) {
                            alertMessage = "A new password has been sent to your email."
                            showAlert = true
                        } else {
                            alertMessage = "Email not found. Please check the email address."
                            showAlert = true
                        }
                    } else {
                        alertMessage = "Please enter a valid email address."
                        showAlert = true
                    }
                }
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
        }
        .background(Color.white)
        .ignoresSafeArea(.keyboard)
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // MARK: - Email Validation
    func isValidEmail(_ email: String) -> Bool {
        let regex = #"^\S+@\S+\.\S+$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }
}
