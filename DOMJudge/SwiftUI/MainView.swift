//
//  MainView.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 11.09.2024.
//

import SwiftUI

struct MainView: View {
    @Binding var isDarkMode: Bool?
    var users: [String: User]
    @Binding var loggedInUser: User?
    @Binding var updateUsers: [String: User]
    @Binding var showLoginPopup: Bool

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HelloWorldView()
            }
            Tab("Account", systemImage: "person") {
                if let user = loggedInUser {
                    AccountView(loggedInUser: $loggedInUser, showLoginPopup: $showLoginPopup)  // Pass bindings to AccountView
                } else {
                    Text("Not logged in")
                }
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView(isDarkMode: $isDarkMode)
            }
        }
    }
}

#Preview {
    MainView(isDarkMode: .constant(nil), users: [:], loggedInUser: .constant(nil), updateUsers: .constant([:]), showLoginPopup: .constant(true))
}
