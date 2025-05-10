
import SwiftUI

struct UserCourses: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var courses: [Course] = []

    var courseTitle: String
    var courseType: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 35, height: 35)
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.black)
                        }
                        .padding(15)
                    }

                    Text(courseTitle)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 8)

                    Spacer()
                }

                // Course List
                VStack(spacing: 10) {
                    ForEach(courses, id: \.id) { course in
                        CourseItem(
                            course: course,
                            showButtons: false,
                            courses: .constant([]) // Read-only mode
                        )
                    }
                }
                .padding(.top, 10)
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            courses = CourseDatabase.shared.fetchCourses(byType: courseType)
        }
    }
}
