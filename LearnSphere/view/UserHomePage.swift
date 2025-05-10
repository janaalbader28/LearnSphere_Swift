
import SwiftUI

struct UserHomePage: View {
    var username: String

    var body: some View {
        NavigationView {
            VStack {
                // Header Section
                HStack {
                    Spacer()
                    Image("logo_4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 85, height: 83)
                        .padding(.bottom, 10)
                }
                .frame(height: 80)
                .background(Color(hex: "#E0EFF4"))

                Spacer().frame(height: 40)

                // Main Title
                Text("What Would you Like to\n Learn Today")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal)

                // Category Buttons
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        NavigationLink(destination: UserCourses(courseTitle: "Developing Courses", courseType: "Developing Courses")) {
                            courseButton(title: "Developing Courses", imageName: "dev2", backgroundColor: .green, imageWidth: 150, imageHeight: 100)
                        }

                        NavigationLink(destination: UserCourses(courseTitle: "UX/UI Courses", courseType: "UX/UI Courses")) {
                            courseButton(title: "UX/UI Courses", imageName: "image_3", backgroundColor: .orange, imageWidth: 150, imageHeight: 100)
                        }
                    }

                    HStack(spacing: 12) {
                        NavigationLink(destination: UserCourses(courseTitle: "AI & ML Courses", courseType: "AI & ML Courses")) {
                            courseButton(title: "AI & ML Courses", imageName: "ai", backgroundColor: .blue, imageWidth: 110, imageHeight: 100)
                        }

                        NavigationLink(destination: UserCourses(courseTitle: "Data Courses", courseType: "Data Courses")) {
                            courseButton(title: "Data Courses", imageName: "ic_5", backgroundColor: .pink, imageWidth: 130, imageHeight: 90)
                        }
                    }
                }
                .padding(.horizontal)

                // Popular Courses Title
                HStack {
                    Text("Popular Courses")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal)

                // Learning Banner Section
                NavigationLink(destination: StartUpPage()) {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Start your learning journey")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                            Text("from here!")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Image("start")
                            .resizable()
                            .frame(width: 100, height: 70)
                            .cornerRadius(8)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, Color(hex: "#FBE6DD")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hex: "#FBE6DD"), lineWidth: 2)
                    )
                    .padding(.horizontal)
                }

                Spacer()
            }
            .navigationBarHidden(true)
            .background(Color.white)
        }
    }

    // MARK: - Reusable course button
    func courseButton(title: String, imageName: String, backgroundColor: Color, imageWidth: CGFloat, imageHeight: CGFloat) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 10)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth, height: imageHeight)
                .padding(.top, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: 170)
        .background(backgroundColor)
        .cornerRadius(12)
        .padding(.top, 6)
    }
}


