import SwiftUI

struct AdminHomePage: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header Section
                HStack {
                    Text("Welcome!")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    Image("logo_4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 85, height: 83)
                        .padding(.trailing, 16)
                        .padding(.bottom, 10)
                }
                .frame(height: 80)
                .background(Color(hex: "#E0EFF4"))
                .padding(.bottom, 20)
                .padding(.top, 60)
                
                // Button for Developing Courses (Blue)
                NavigationLink(destination: AdminCourses(type: "Developing Courses")) {
                    HStack {
                        Image("dev2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("Developing Courses")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    .padding(.horizontal, 10)
                }
                .padding(.bottom, 20)
                
                // Button for UX/UI Courses (Orange)
                NavigationLink(destination: AdminCourses(type: "UX/UI Courses")) {
                    HStack {
                        Image("image_3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("UX/UI Courses")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange))
                    .padding(.horizontal, 10)
                }
                .padding(.bottom, 20)
                
                // Button for AI & ML Courses (Green)
                NavigationLink(destination: AdminCourses(type: "AI & ML Courses")) {
                    HStack {
                        Image("ai")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("AI & ML Courses")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                    .padding(.horizontal, 10)
                }
                .padding(.bottom, 20)
                
                // Button for Data Courses (Pink)
                NavigationLink(destination: AdminCourses(type: "Data Courses")) {
                    HStack {
                        Image("ic_5")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("Data Courses")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.pink))
                    .padding(.horizontal, 10)
                }
                .padding(.bottom, 20)
                
                Spacer()
            }
            .padding(.top, 20)
            .background(Color.white)
            .edgesIgnoringSafeArea(.top)
        }
    }
}



// Helper Extension to Handle Hex Colors
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        if hex.hasPrefix("#") {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let r = Double((color & 0xFF0000) >> 16) / 255.0
        let g = Double((color & 0x00FF00) >> 8) / 255.0
        let b = Double(color & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
