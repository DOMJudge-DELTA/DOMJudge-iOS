//
//  AccountView.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 11.09.2024.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        Image(systemName: "person")
            .imageScale(.large)
            .foregroundStyle(.tint)
        
        Text("Account")
        
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
    AccountView()
}
