
import SwiftUI

struct CourseItem: View {
    var course: Course
    var showButtons: Bool
    @Binding var courses: [Course]

    @State private var navigateToUpdate = false
    @State private var showDeleteAlert = false

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(course.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)

                    Text(course.info)
                        .foregroundColor(.black)

                    Text("Date: \(course.date)")
                        .foregroundColor(.black)

                    Text("Location: \(course.location)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.blue)

                    if showButtons {
                        HStack(spacing: 12) {
                            Button(action: { showDeleteAlert = true }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }

                            Button(action: { navigateToUpdate = true }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.top, 6)
                    }
                }

                Spacer()

                if let img = UIImage(contentsOfFile: course.imagePath) {
                    Image(uiImage: img)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding()
            .background(
                ZStack {
                    Image("bg_1")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .cornerRadius(15)
                    Color.white.opacity(0.6)
                        .cornerRadius(15)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
            .onTapGesture {
                if !showButtons {
                    openCourseURL(course.url)
                }
            }

            NavigationLink("", destination: UpdateCourse(course: course, courses: $courses), isActive: $navigateToUpdate)
                .hidden()
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Course"),
                message: Text("Are you sure you want to delete this course?"),
                primaryButton: .destructive(Text("Delete")) {
                    CourseDatabase.shared.deleteCourse(courseId: course.id)
                    courses = CourseDatabase.shared.fetchCourses(byType: "all")
                },
                secondaryButton: .cancel()
            )
        }
        .padding(.bottom, 10)
    }

    func openCourseURL(_ urlString: String) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            print("Invalid URL: \(urlString)")
            return
        }
        UIApplication.shared.open(url)
    }
}
