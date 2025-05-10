//
//  AdminTabView.swift
//  LearnSphere
//
//  Created by Jana on 07/05/2025.
//

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
