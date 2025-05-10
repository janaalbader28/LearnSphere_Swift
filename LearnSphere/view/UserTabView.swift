

import SwiftUI

struct MainTabView: View {
    var username: String

    var body: some View {
        TabView {
            UserHomePage(username: username)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            ChallengesPage()
                .tabItem {
                    Image(systemName: "puzzlepiece.extension")
                    Text("Challenges")
                }
            

            ExpertPage()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Experts")
                }

            UserSettingsPage(username: username)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}
