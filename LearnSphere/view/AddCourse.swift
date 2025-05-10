
import SwiftUI

struct AddCourse: View {
    var courseType: String
    @Binding var courses: [Course] // REFRESH admin course list

    @State private var courseTitle: String = ""
    @State private var courseInfo: String = ""
    @State private var courseUrl: String = ""
    @State private var selectedLocation: String = "Select Location"
    @State private var showImagePicker = false
    @State private var courseImage: UIImage?
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    let locations = ["Online", "In-Person"]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            // Top bar
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

                Text("Add Course")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding(.vertical, 10)

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Image Picker
                    Button(action: {
                        showImagePicker = true
                    }) {
                        if let image = courseImage {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $courseImage)
                    }

                    Group {
                        Text("Course Title :")
                            .font(.system(size: 18))
                        TextField("Enter Course Title", text: $courseTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Course Info :")
                            .font(.system(size: 18))
                        TextField("Enter Course Info", text: $courseInfo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Course Date :")
                            .font(.system(size: 18))
                        HStack {
                            Text(formatDate(selectedDate))
                                .foregroundColor(.gray)
                            Spacer()
                            Button(action: {
                                showDatePicker.toggle()
                            }) {
                                Image(systemName: "calendar")
                                    .foregroundColor(.blue)
                                    .padding(8)
                                    .background(Circle().fill(Color.blue.opacity(0.1)))
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))

                        Text("Course Url :")
                            .font(.system(size: 18))
                        TextField("Enter Course Url", text: $courseUrl)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Location :")
                            .font(.system(size: 18))
                        Menu {
                            ForEach(locations, id: \.self) { location in
                                Button(location) {
                                    selectedLocation = location
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedLocation)
                                    .foregroundColor(selectedLocation == "Select Location" ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        }
                    }

                    // Add Course Button
                    Button(action: {
                        guard !courseTitle.isEmpty,
                              !courseInfo.isEmpty,
                              !courseUrl.isEmpty,
                              selectedLocation != "Select Location",
                              let image = courseImage else {
                            alertMessage = "Please fill in all the fields including the image."
                            showAlert = true
                            return
                        }

                        let imageFileName = UUID().uuidString + ".jpg"
                        if let imagePath = saveImageToDocuments(image, fileName: imageFileName) {
                            CourseDatabase.shared.insertCourse(
                                title: courseTitle,
                                info: courseInfo,
                                url: courseUrl,
                                location: selectedLocation,
                                date: selectedDate,
                                type: courseType,
                                imagePath: imagePath
                            )

                            alertMessage = "Course added successfully!"
                            showAlert = true

                            // Refresh courses list
                            courses = CourseDatabase.shared.fetchCourses(byType: courseType)

                            // Go back after slight delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            alertMessage = "Failed to save image."
                            showAlert = true
                        }
                    }) {
                        Text("Add Course")
                            .font(.system(size: 20, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showDatePicker) {
            GraphicalDatePicker(selectedDate: $selectedDate)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Add Course"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    func saveImageToDocuments(_ image: UIImage, fileName: String) -> String? {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = directory.appendingPathComponent(fileName)
            do {
                try data.write(to: fileURL)
                return fileURL.path
            } catch {
                print("Saving image failed: \(error)")
            }
        }
        return nil
    }

    func clearFields() {
        courseTitle = ""
        courseInfo = ""
        courseUrl = ""
        selectedLocation = "Select Location"
        courseImage = nil
        selectedDate = Date()
    }
}
