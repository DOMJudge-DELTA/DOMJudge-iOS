//
//  DOMJudgeApp.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 11.09.2024.
//

import SwiftUI

@main
struct DOMJudgeApp: App {
    @AppStorage("isDarkMode") var isDarkMode : Bool?
    @State var users : [String:User] = UserDefaults.standard.loadUsers() ?? [:]
    
    var body: some Scene {
        WindowGroup {
            MainView(isDarkMode: $isDarkMode, users: users)
                .preferredColorScheme(isDarkMode == nil ? nil : (isDarkMode! ? .dark : .light))  // Use nil for system default
                .onDisappear {
                    UserDefaults.standard.saveUsers(users)
                }
        }
    }
}

#Preview{
    MainView(isDarkMode: .constant(nil), users: [:])
}
