import SwiftUI

struct ChallengesPage: View {
    var body: some View {
        VStack(spacing: 30) {
            // Header Section
            HStack {
                Spacer()
                Text("Challenges")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                Spacer()

                Image("logo_4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 83, height: 85)
                    .padding(.bottom, 10)
            }
            .frame(height: 80)
            .background(Color.blue.opacity(0.2)) 


            // Challenge Buttons Section
            ScrollView {
                VStack(spacing: 10) {
                    ChallengeButton(
                        imageName: "codewar",
                        title: "Codewars",
                        description: "Master coding skills with interactive challenges across multiple languages.",
                        languages: "C++, Swift, Java, Python",
                        url: "https://www.codewars.com"
                    )

                    ChallengeButton(
                        imageName: "codecombat",
                        title: "CodeCombat",
                        description: "Learn programming through games and challenges.",
                        languages: "JavaScript, Python",
                        url: "https://codecombat.com"
                    )

                    ChallengeButton(
                        imageName: "coderhub",
                        title: "CoderHub",
                        description: "Code challenges and learning resources.",
                        languages: "Java, C++, Python and more",
                        url: "https://coderhub.sa" // Replace with correct URL if different
                    )

                    ChallengeButton(
                        imageName: "screeps",
                        title: "Screeps",
                        description: "The MMO strategy game for programmers.",
                        languages: "JavaScript, C++",
                        url: "https://screeps.com"
                    )

                    Text("More coming soon!")
                        .foregroundColor(.black)
                        .padding(.top, 20)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 10)
            }

            Spacer()
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

struct ChallengeButton: View {
    var imageName: String
    var title: String
    var description: String
    var languages: String
    var url: String

    var body: some View {
        Button(action: {
            if let link = URL(string: url) {
                UIApplication.shared.open(link)
            }
        }) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    Text("Languages: \(languages)")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .padding(.top, 8)
                }
                .padding(.leading, 16)

                Spacer()
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ChallengesPage_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesPage()
    }
}
