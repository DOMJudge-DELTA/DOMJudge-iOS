//
//  DOMJudgeApp.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 11.09.2024.
//

import SwiftUI

@main
struct DOMJudgeApp: App {
    @AppStorage("isDarkMode") var isDarkMode: Bool?
    
    @State var users: [String: User] = UserDefaults.standard.loadUsers() ?? [:]
    @State var loggedInUser: User? = UserDefaults.standard.loadLoggedInUser()
    @State var showLoginPopup: Bool = false  // Manage login popup visibility
    
    var body: some Scene {
        WindowGroup {
            MainView(isDarkMode: $isDarkMode, users: users, loggedInUser: $loggedInUser, updateUsers: $users, showLoginPopup: $showLoginPopup)
                 .preferredColorScheme(isDarkMode == nil ? nil : (isDarkMode! ? .dark : .light))
                .onAppear {
                    if loggedInUser == nil {
                        showLoginPopup = true  // Show login if no user is logged in
                    }
                }
                .sheet(isPresented: $showLoginPopup) {
                    LoginView(showLoginPopup: $showLoginPopup, loggedInUser: $loggedInUser, users: $users)
                }
                .onDisappear {
                    UserDefaults.standard.saveUsers(users)  // Save users when app disappears
                }
        }
    }
}

#Preview {
    MainView(isDarkMode: .constant(nil), users: [:], loggedInUser: .constant(nil), updateUsers: .constant([:]), showLoginPopup: .constant(false))
}
