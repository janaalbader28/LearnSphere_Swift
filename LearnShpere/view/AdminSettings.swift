import SwiftUI

struct AdminSettings: View {
    @State private var navigateToPartnerContacts = false
    @State private var navigateToLogin = false
    @State private var showLogoutAlert = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // Header Section
                    HStack {
                        Spacer()
                        Text("Settings")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        Spacer()

                        Image("logo_4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 85, height: 83)
                            .padding(.bottom, 10)
                    }
                    .frame(height: 90)
                    .background(Color(hex: "#E0EFF4"))
                    .padding(.top, 60)

                    Spacer().frame(height: geometry.size.height / 4)

                    // Buttons Section
                    VStack(spacing: 20) {
                        Button(action: {
                            navigateToPartnerContacts = true
                        }) {
                            Text("Partner Contacts")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal, 40)

                        
                        Button(action: {
                            showLogoutAlert = true
                        }) {
                            Text("Logout")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal, 40)
                        .alert(isPresented: $showLogoutAlert) {
                            Alert(
                                title: Text("Confirm Logout"),
                                message: Text("Are you sure you want to log out?"),
                                primaryButton: .destructive(Text("Logout")) {
                                    navigateToLogin = true
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }

                    // Navigation Links
                    NavigationLink(destination: PartnerContacts(), isActive: $navigateToPartnerContacts) {
                        EmptyView()
                    }

                    NavigationLink(destination: Login(), isActive: $navigateToLogin) {
                        EmptyView()
                    }

                    Spacer()
                }
                .frame(minHeight: geometry.size.height)
                .background(Color.white)
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}
