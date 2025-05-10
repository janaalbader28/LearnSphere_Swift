import SwiftUI

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var navigateToAdmin = false
    @State private var navigateToUser = false
    @State private var navigateToSignup = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                Text("Evaluate your \nlearning experience \nToday")
                    .font(.system(size: 26, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.top, 36)
                    .padding(.bottom, 20)
                
                
                Image("image_1")
                    .resizable()
                    .frame(width: 150, height: 130)
                    .scaledToFit()
                
                VStack(spacing: 20) {
                    TextField("User Name", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .padding(.horizontal, 8)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .padding(.horizontal, 8)
                    
                    Button("Login") {
                        // Check credentials and set navigation flags
                        if username == "Admin" && password == "12345678" {
                            navigateToAdmin = true
                            navigateToUser = false // Reset user flag
                        }
                        
                        else if UserDatabase.shared.login(username: username, password: password) {
                            navigateToUser = true
                        } else {
                            alertMessage = "Invalid username or password."
                            showAlert = true
                        }
                    }

                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 8)
                    
            
                    
                    NavigationLink(destination: SignUpPage(), isActive: $navigateToSignup) {
                                        Button("Sign Up") {
                                            navigateToSignup = true
                                        }
                                        .font(.system(size: 20))
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.purple)
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                        .padding(.horizontal, 8)
                                    }

                    
                    
                    NavigationLink(destination: ForgotPassword()) {
                        Text("Forgot Password ?")
                            .foregroundColor(.blue)
                            .padding(10)
                    }
                    .padding(.top, 10)
                    
                    NavigationLink(destination: AdminTabView(), isActive: $navigateToAdmin) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: MainTabView(username: username), isActive: $navigateToUser) {
                        EmptyView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
                       .alert(isPresented: $showAlert) {
                           Alert(title: Text("Login Error"),
                                 message: Text(alertMessage),
                                 dismissButton: .default(Text("OK")))
                       }
                   }
               }
           }
