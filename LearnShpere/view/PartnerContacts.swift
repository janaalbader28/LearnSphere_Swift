import SwiftUI

struct PartnerContacts: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
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

                    Text("Partner Contacts")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 10)

                    Spacer()
                }
                .frame(height: 100)

                // Partner Cards
                partnerCard(
                    title: "Coursera",
                    email: "contact@coursera.com",
                    phone: "+1234567890",
                    programs: "Online Bootcamps, Short Courses",
                    url: "https://www.coursera.org"
                )
                partnerCard(
                    title: "SDAIA",
                    email: "contact@sdaia.gov.sa",
                    phone: "+966112233445",
                    programs: "AI & Data Science Courses, Bootcamps",
                    url: "https://sdaia.gov.sa"
                )
                partnerCard(
                    title: "Tuwaiq",
                    email: "contact@tuwaiq.sa",
                    phone: "+966234567890",
                    programs: "Data Science, AI Bootcamps",
                    url: "https://tuwaiq.edu.sa"
                )
                partnerCard(
                    title: "Audacity",
                    email: "support@audacityteam.org",
                    phone: "+1-800-555-5555",
                    programs: "Audio Engineering, Audio Editing Courses",
                    url: "https://www.audacityteam.org"
                )

                Text("More coming soon!")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.bottom, 30)
            }
            .padding(.horizontal, 16)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    // MARK: - Partner Card View
    func partnerCard(title: String, email: String, phone: String, programs: String, url: String) -> some View {
        Button(action: {
            if let website = URL(string: url), UIApplication.shared.canOpenURL(website) {
                UIApplication.shared.open(website)
            }
        }) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    Text("Email: \(email)")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Text("Phone: \(phone)")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Text("Programs: \(programs)")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .padding(.top, 6)
                }
                Spacer()
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PartnerContacts_Previews: PreviewProvider {
    static var previews: some View {
        PartnerContacts()
    }
}
