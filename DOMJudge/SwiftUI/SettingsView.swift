//
//  SettingsView.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 11.09.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Image(systemName: "gear")
            .imageScale(.large)
            .foregroundStyle(.tint)
        Text("Settings")
        
        TabView {
            Tab("Home", systemImage: "house") {
                MainView()
            }
            Tab("Account", systemImage: "person") {
                AccountView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
        
    }
}

#Preview {
    SettingsView()
}
