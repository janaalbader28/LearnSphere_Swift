import SwiftUI
import MapKit

struct ContactUs: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
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

                    Text("Contact Us")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 10)

                    Spacer()
                }
                .frame(height: 80)

                // Phone Call Card
                contactCard(
                    imageName: "call",
                    title: "Call the Support Team",
                    detail: "+966 597267869"
                ) {
                    if let url = URL(string: "tel://966597267869"),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }

                // Email Card
                contactCard(
                    imageName: "email",
                    title: "Send an Email",
                    detail: "ContactUs@LearnSphere.com"
                ) {
                    Link("Send an Email", destination: URL(string: "mailto:ContactUs@LearnSphere.com")!)
                        .foregroundColor(.blue) // Optional, to customize the text color

                }

                // Instagram Card
                contactCard(
                    imageName: "insta",
                    title: "Visit Instagram",
                    detail: "learnshpere.cs"
                ) {
                    if let url = URL(string: "https://www.instagram.com/learnshpere.cs"),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }

                // Location Map
                VStack(alignment: .leading, spacing: 10) {
                    Text("Location")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 15)
                        .padding(.top, 15)

                    MapView()
                        .frame(height: 180)
                        .cornerRadius(10)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 15)
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 10)
                .padding(.bottom, 40)
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
    }

    // Contact Card View with Action
    func contactCard(imageName: String, title: String, detail: String, action: (() -> Void)? = nil) -> some View {
        Button(action: {
            action?()
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.leading, 10)

                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)

                    Text(detail)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 10)

                Spacer()
            }
            .contentShape(Rectangle()) // Ensure full area is tappable
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal, 10)
        }
    }
}

// Map View
struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 24.7136, longitude: 46.6753),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        Map(coordinateRegion: $region)
    }
}
