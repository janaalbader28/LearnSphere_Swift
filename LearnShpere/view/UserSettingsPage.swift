
import SwiftUI

struct UserSettingsPage: View {
    enum ActiveAlert {
        case logout, delete
    }

    @State private var navigateToLogin = false
    @State private var navigateToContactUs = false
    @State private var navigateToUpdateProfile = false
    @State private var activeAlert: ActiveAlert? = nil

    var username: String

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // Header
                    HStack {
                        Spacer()
                        Text("Settings")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.top, 70)

                        Spacer()

                        Image("logo_4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 83, height: 85)
                            .padding(.bottom, 30)
                            .padding(.top, 70)
                    }
                    .frame(height: 140)
                    .background(Color(hex: "#E0EFF4"))

                    Spacer().frame(height: geometry.size.height / 6)

                    // Buttons Section
                    VStack(spacing: 20) {
                        Button(action: {
                            activeAlert = .logout
                        }) {
                            Text("Logout")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(15)
                        }

                        Button(action: {
                            navigateToUpdateProfile = true
                        }) {
                            Text("Update Profile")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(15)
                        }

                        Button(action: {
                            navigateToContactUs = true
                        }) {
                            Text("Contact Us")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(15)
                        }

                        Button(action: {
                            activeAlert = .delete
                        }) {
                            Text("Delete Account")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 40)

                    // Navigation
                    NavigationLink(destination: Login(), isActive: $navigateToLogin) { EmptyView() }
                    NavigationLink(destination: ContactUs(), isActive: $navigateToContactUs) { EmptyView() }
                    NavigationLink(destination: UpdateProfile(username: username), isActive: $navigateToUpdateProfile) { EmptyView() }

                    Spacer()
                }
                .frame(minHeight: geometry.size.height)
                .background(Color.white)
                .navigationBarHidden(true)
                .alert(item: $activeAlert) { alert in
                    switch alert {
                    case .logout:
                        return Alert(
                            title: Text("Confirm Logout"),
                            message: Text("Are you sure you want to log out?"),
                            primaryButton: .destructive(Text("Logout")) {
                                navigateToLogin = true
                            },
                            secondaryButton: .cancel()
                        )
                    case .delete:
                        return Alert(
                            title: Text("Delete Account"),
                            message: Text("Are you sure you want to permanently delete your account?"),
                            primaryButton: .destructive(Text("Delete")) {
                                UserDatabase.shared.deleteUser(username: username)
                                navigateToLogin = true
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

extension UserSettingsPage.ActiveAlert: Identifiable {
    var id: Int {
        switch self {
        case .logout: return 1
        case .delete: return 2
        }
    }
}
