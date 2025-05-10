
import SwiftUI
import PhotosUI

struct UpdateCourse: View {
    var course: Course
    @Binding var courses: [Course]

    @Environment(\.presentationMode) var presentationMode

    @State private var courseTitle: String
    @State private var courseInfo: String
    @State private var selectedDate: Date
    @State private var courseUrl: String
    @State private var selectedLocation: String
    @State private var courseImage: UIImage?
    @State private var showImagePicker = false
    @State private var showDatePicker = false
    @State private var showAlert = false

    let locations = ["Online", "In-Person"]

    init(course: Course, courses: Binding<[Course]>) {
        self.course = course
        self._courses = courses
        _courseTitle = State(initialValue: course.title)
        _courseInfo = State(initialValue: course.info)
        _courseUrl = State(initialValue: course.url)
        _selectedLocation = State(initialValue: course.location)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        _selectedDate = State(initialValue: formatter.date(from: course.date) ?? Date())
        _courseImage = State(initialValue: UIImage(contentsOfFile: course.imagePath))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Button(action: { showImagePicker.toggle() }) {
                    if let image = courseImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Image("tuwaiq")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

                fieldBlock(label: "Course Title", text: $courseTitle)
                fieldBlock(label: "Course Info", text: $courseInfo)
                fieldBlock(label: "Course URL", text: $courseUrl)

                DatePicker("Course Date", selection: $selectedDate, displayedComponents: .date)

                Picker("Location", selection: $selectedLocation) {
                    ForEach(locations, id: \.self) { location in
                        Text(location)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Button("Save Changes") {
                    saveChanges()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(15)
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $courseImage)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Course Updated"), message: Text("The course was successfully updated."), dismissButton: .default(Text("OK")))
        }
    }

    func fieldBlock(label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(label, text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }

    func saveChanges() {
        var updatedImagePath = course.imagePath
        if let image = courseImage {
            let fileName = UUID().uuidString + ".jpg"
            if let newPath = saveImageToDocuments(image, fileName: fileName) {
                updatedImagePath = newPath
            }
        }

        CourseDatabase.shared.updateCourse(
            id: course.id,
            title: courseTitle,
            info: courseInfo,
            url: courseUrl,
            location: selectedLocation,
            date: selectedDate,
            imagePath: updatedImagePath
        )

        // Default to "all" or refetch based on location/type as needed
        courses = CourseDatabase.shared.fetchCourses(byType: "all")
        showAlert = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            presentationMode.wrappedValue.dismiss()
        }
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
}
