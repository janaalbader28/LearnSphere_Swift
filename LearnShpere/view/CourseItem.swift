//////
//////import SwiftUI
//////
//////struct CourseItem: View {
//////    var courseTitle: String
//////    var courseInfo: String
//////    var courseDate: String
//////    var location: String
//////    var imageName: String
//////    var courseURL: String
//////    var showButtons: Bool
//////    var courseId: Int64
//////    @Binding var courses: [Course]  // Binding to the parent view's courses list
//////
//////    @State private var navigateToUpdate = false
//////    @State private var showDeleteAlert = false // State to control the delete confirmation alert
//////
//////    var body: some View {
//////        VStack {
//////            Spacer()
//////
//////            Button(action: {
//////                if let url = URL(string: courseURL), UIApplication.shared.canOpenURL(url) {
//////                    UIApplication.shared.open(url)
//////                }
//////            }) {
//////                HStack {
//////                    VStack(alignment: .leading, spacing: 8) {
//////                        Text(courseTitle)
//////                            .font(.system(size: 16, weight: .bold))
//////                            .foregroundColor(.black)
//////                            .lineLimit(nil)
//////                            .fixedSize(horizontal: false, vertical: true)
//////
//////                        Text(courseInfo)
//////                            .foregroundColor(.black)
//////                            .lineLimit(nil)
//////                            .fixedSize(horizontal: false, vertical: true)
//////
//////                        Text(courseDate)
//////                            .foregroundColor(.black)
//////                            .lineLimit(nil)
//////                            .fixedSize(horizontal: false, vertical: true)
//////
//////                        Text(location)
//////                            .font(.system(size: 18, weight: .bold))
//////                            .foregroundColor(Color("#0F357E"))
//////                            .lineLimit(nil)
//////                            .fixedSize(horizontal: false, vertical: true)
//////
//////                        if showButtons {
//////                            HStack(spacing: 12) {
//////                                Button(action: {
//////                                    // Show the delete confirmation alert
//////                                    showDeleteAlert = true
//////                                }) {
//////                                    Image(systemName: "trash")
//////                                        .resizable()
//////                                        .frame(width: 24, height: 24)
//////                                        .padding(5)
//////                                }
//////
//////                                NavigationLink(destination: UpdateCourse(), isActive: $navigateToUpdate) {
//////                                    EmptyView()
//////                                }
//////                                Button(action: {
//////                                    navigateToUpdate = true
//////                                }) {
//////                                    Image(systemName: "pencil")
//////                                        .resizable()
//////                                        .frame(width: 24, height: 24)
//////                                        .padding(5)
//////                                }
//////                            }
//////                            .padding(.top, 10)
//////                        }
//////                    }
//////                    .padding([.leading, .top, .bottom], 8)
//////
//////                    Spacer()
//////
//////                    Image(imageName)
//////                        .resizable()
//////                        .scaledToFill()
//////                        .frame(width: 100, height: 100)
//////                        .clipShape(RoundedRectangle(cornerRadius: 10))
//////                        .padding(.horizontal, 10)
//////                }
//////                .background(
//////                    Image("bg_1")
//////                        .resizable()
//////                        .scaledToFill()
//////                        .cornerRadius(20)
//////                )
//////                .frame(height: 150)
//////                .padding([.top, .horizontal], 16)
//////                .frame(maxWidth: 350)
//////            }
//////
//////            Spacer()
//////        }
//////        .padding(.bottom, 20)
//////        .frame(maxWidth: .infinity, maxHeight: .infinity)
//////        .alert(isPresented: $showDeleteAlert) {
//////            Alert(
//////                title: Text("Delete Course"),
//////                message: Text("Are you sure you want to delete this course?"),
//////                primaryButton: .destructive(Text("Delete")) {
//////                    // Perform the delete operation if confirmed
//////                    CourseDatabase.shared.deleteCourse(courseId: courseId)
//////                    print("Course deleted successfully.")
//////                    
//////                    // Re-fetch the courses to update the UI
//////                    courses = CourseDatabase.shared.fetchCourses(byType: "all")  // Adjust to fetch based on the appropriate course type
//////                },
//////                secondaryButton: .cancel()
//////            )
//////        }
//////    }
//////}
////// CourseItem.swift
///
///
////import SwiftUI
////
////struct CourseItem: View {
////    var course: Course
////    var showButtons: Bool
////    @Binding var courses: [Course]
////
////    @State private var navigateToUpdate = false
////    @State private var showDeleteAlert = false
////
////    var body: some View {
////        VStack {
////            HStack {
////                VStack(alignment: .leading, spacing: 8) {
////                    Text(course.title).bold()
////                    Text(course.info)
////                    Text("Date: \(course.date)")
////                    Text("Location: \(course.location)")
////
////                    if showButtons {
////                        HStack {
////                            Button(action: { showDeleteAlert = true }) {
////                                Image(systemName: "trash")
////                            }
////                            Button(action: { navigateToUpdate = true }) {
////                                Image(systemName: "pencil")
////                            }
////                        }
////                    }
////                }
////
////                Spacer()
////
////                if let img = UIImage(contentsOfFile: course.imagePath) {
////                    Image(uiImage: img)
////                        .resizable()
////                        .frame(width: 100, height: 100)
////                        .clipShape(RoundedRectangle(cornerRadius: 10))
////                }
////            }
////            .padding()
////            .background(RoundedRectangle(cornerRadius: 15).stroke())
////            .padding(.horizontal)
////
////            NavigationLink("", destination: UpdateCourse(course: course, courses: $courses), isActive: $navigateToUpdate)
////                .hidden()
////        }
////        .alert(isPresented: $showDeleteAlert) {
////            Alert(
////                title: Text("Delete Course"),
////                message: Text("Are you sure you want to delete this course?"),
////                primaryButton: .destructive(Text("Delete")) {
////                    CourseDatabase.shared.deleteCourse(courseId: course.id)
////                    courses = CourseDatabase.shared.fetchCourses(byType: course.type)
////                },
////                secondaryButton: .cancel()
////            )
////        }
////    }
////}
//import SwiftUI
//
//struct CourseItem: View {
//    var course: Course
//    var showButtons: Bool
//    @Binding var courses: [Course]
//
//    @State private var navigateToUpdate = false
//    @State private var showDeleteAlert = false
//
//    var body: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(course.title).bold()
//                    Text(course.info)
//                    Text("Date: \(course.date)")
//                    Text("Location: \(course.location)")
//
//                    if showButtons {
//                        HStack {
//                            Button(action: { showDeleteAlert = true }) {
//                                Image(systemName: "trash")
//                            }
//                            Button(action: { navigateToUpdate = true }) {
//                                Image(systemName: "pencil")
//                            }
//                        }
//                    }
//                }
//
//                Spacer()
//
//                if let img = UIImage(contentsOfFile: course.imagePath) {
//                    Image(uiImage: img)
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                }
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 15).stroke())
//            .padding(.horizontal)
//            .onTapGesture {
//                if !showButtons {
//                    openCourseURL(course.url)
//                }
//            }
//
//            NavigationLink("", destination: UpdateCourse(course: course, courses: $courses), isActive: $navigateToUpdate)
//                .hidden()
//        }
//        .alert(isPresented: $showDeleteAlert) {
//            Alert(
//                title: Text("Delete Course"),
//                message: Text("Are you sure you want to delete this course?"),
//                primaryButton: .destructive(Text("Delete")) {
//                    CourseDatabase.shared.deleteCourse(courseId: course.id)
//                    courses = CourseDatabase.shared.fetchCourses(byType: "all") // fallback for now
//                },
//                secondaryButton: .cancel()
//            )
//        }
//    }
//
//    func openCourseURL(_ urlString: String) {
//        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
//            print("Invalid URL: \(urlString)")
//            return
//        }
//        UIApplication.shared.open(url)
//    }
//}
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
                    // Optional: add a light overlay if text becomes unreadable
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
