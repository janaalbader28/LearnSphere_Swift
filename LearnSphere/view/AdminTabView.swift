
import SwiftUI

struct AdminTabView: View {
    var body: some View {
        TabView {
            AdminHomePage()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            AdminSettings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}
