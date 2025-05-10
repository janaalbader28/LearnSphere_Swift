
import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea() // Background color
                
                NavigationLink(destination: Login()) {
                    VStack {
                        Spacer()
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
