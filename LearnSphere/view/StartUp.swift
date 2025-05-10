import SwiftUI

struct StartUpPage: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Top bar with back button and welcome message
                HStack(alignment: .center) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Circle().stroke(Color.black, lineWidth: 1))
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Welcome to Your Programming Journey!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                    }
                    .padding(.leading, 5)

                    Spacer()
                }
                .padding(.horizontal)

                // Step 1
                CardView(
                    title: "Step 1: Install Visual Studio",
                    description: "Get started by downloading and installing Visual Studio, a powerful code editor.",
                    buttonTitle: "Download Visual Studio",
                    link: "https://visualstudio.microsoft.com/downloads/"
                )

                // Step 2
                CardView(
                    title: "Step 2: Set Up GitHub",
                    description: "Create a GitHub account to store and manage your code projects online.",
                    buttonTitle: "Create a GitHub Account",
                    link: "https://github.com/join"
                )

                // Step 3 with Image
                CardWithImageView(
                    title: "Step 3: Test Your Knowledge",
                    description: "Challenge yourself with a quick coding quiz to reinforce what you've learned!",
                    buttonTitle: "Take a Coding Quiz",
                    link: "https://www.codecademy.com/learn/paths/computer-science",
                    imageName: "test"
                )

                // Step 4
                CardView(
                    title: "Step 4: Explore Your Programming Roadmap",
                    description: "Check out roadmap.sh for a guide to different programming languages, frameworks, and tools.",
                    buttonTitle: "Visit Roadmap.sh",
                    link: "https://roadmap.sh/"
                )
            }
            .padding(.vertical)
        }
        .navigationBarHidden(true)
        .background(Color.white)
    }
}

// MARK: - Basic Card View
struct CardView: View {
    var title: String
    var description: String
    var buttonTitle: String
    var link: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.red)
                .bold()

            Text(description)
                .font(.subheadline) // Smaller text size
                .foregroundColor(.primary)

            // Use Link to open URL
            Link(destination: URL(string: link)!) {
                Text(buttonTitle)
                    .foregroundColor(.white)
                    .padding(6) // Reduced padding for smaller buttons
                    .background(Color.purple)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, alignment: .leading) // Align the button to the left
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

// MARK: - Card With Image
struct CardWithImageView: View {
    var title: String
    var description: String
    var buttonTitle: String
    var link: String
    var imageName: String

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.red)
                    .bold()

                Text(description)
                    .font(.subheadline) // Smaller text size
                    .foregroundColor(.primary)

                // Use Link to open URL
                Link(destination: URL(string: link)!) {
                    Text(buttonTitle)
                        .foregroundColor(.white)
                        .padding(6) // Reduced padding for smaller buttons
                        .background(Color.purple)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .leading) // Align the button to the left
                }
            }

            Spacer()

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}
