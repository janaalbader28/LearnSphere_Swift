
import SwiftUI

struct AdminCourses: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToAdd = false
    @State private var courses: [Course] = []
    var type: String

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                    }
                    Text(type).font(.largeTitle)
                    Spacer()
                }
                .padding()

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(courses, id: \.id) { course in
                            CourseItem(course: course, showButtons: true, courses: $courses)
                        }
                    }
                }

                NavigationLink(destination: AddCourse(courseType: type, courses: $courses), isActive: $navigateToAdd) {
                    EmptyView()
                }

                Button(action: { navigateToAdd = true }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Circle().fill(Color.purple))
                        .foregroundColor(.white)
                }
                .padding()
            }
            .onAppear {
                courses = CourseDatabase.shared.fetchCourses(byType: type)
            }
        }
    }
}
