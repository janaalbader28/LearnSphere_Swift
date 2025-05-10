import SwiftUI
import PhotosUI

struct ExpertPage: View {
    @State private var phone = ""
    @State private var email = ""
    @State private var answer = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var wordCount: Int {
        answer.split { $0.isWhitespace || $0.isNewline }.count
    }

    var body: some View {
        ScrollView {
            VStack {
                // Header Section
                HStack {
                    Spacer()
                    Text("Ask Experts")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 50)

                    Spacer()

                    Image("logo_4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 83, height: 85)
                        .padding(.bottom, 10)
                        .padding(.top, 50)
                }
                .frame(height: 140)
                .background(Color.blue.opacity(0.2)) 
                .ignoresSafeArea(edges: .top)

                // Form Fields
                VStack(alignment: .leading, spacing: 15) {
                    Group {
                        Text("Phone Number")
                            .font(.system(size: 16, weight: .bold))
                        TextField("Enter your phone number", text: $phone)
                            .keyboardType(.phonePad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Email")
                            .font(.system(size: 16, weight: .bold))
                        TextField("Enter your email", text: $email)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Please enter your question(s) below")
                            .font(.system(size: 16, weight: .bold))

                        TextEditor(text: $answer)
                            .frame(height: 140)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
                            .padding(.top, 5)

                        Text("Word count: \(wordCount)/200")
                            .font(.caption)
                            .foregroundColor(wordCount > 200 ? .red : .gray)
                    }

                    // Upload Image
                    Text("Upload an image (Optional)")
                        .font(.system(size: 16, weight: .bold))

                    Button("Choose Image") {
                        showImagePicker = true
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(15)

                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                    }

                    // Submit Button
                    Button(action: {
                        if validateInputs() {
                            // Handle submission
                            alertMessage = "Your question has been submitted!"
                            showAlert = true
                            
                            // Clear the form after submission
                            clearForm()
                        }
                    }) {
                        Text("Submit")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .frame(width: 300)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(16)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
    }

    // MARK: - Validation
    func validateInputs() -> Bool {
        if phone.trimmingCharacters(in: .whitespaces).isEmpty || !isValidPhone(phone) {
            alertMessage = "Please enter a valid phone number."
            showAlert = true
            return false
        }

        if email.trimmingCharacters(in: .whitespaces).isEmpty || !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return false
        }

        if answer.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter a question."
            showAlert = true
            return false
        }

        if wordCount > 200 {
            alertMessage = "Your question must be less than 200 words."
            showAlert = true
            return false
        }

        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        let regex = #"^\S+@\S+\.\S+$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }

    func isValidPhone(_ phone: String) -> Bool {
        let regex = #"^\d{10}$"#
        return phone.range(of: regex, options: .regularExpression) != nil
    }

    // MARK: - Clear Form
    func clearForm() {
        phone = ""
        email = ""
        answer = ""
        selectedImage = nil
    }
}
