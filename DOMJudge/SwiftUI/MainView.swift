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
    
    var body: some View {
        TabView{
            Tab("Home", systemImage: "house") {
                HelloWorldView()
            }
            Tab("Account", systemImage: "person") {
                AccountView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView(isDarkMode: $isDarkMode)
            }
        }
    }
}

#Preview {
    MainView(isDarkMode: .constant(true), users: [:])
}

