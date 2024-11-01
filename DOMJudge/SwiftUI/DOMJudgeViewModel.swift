import SwiftUI
import Combine

class DOMJudgeViewModel: ObservableObject {
    @Published var isDarkMode: Bool? = UserDefaults.standard.bool(forKey: "isDarkMode")
    @Published var users: [String: User] = UserDefaults.standard.loadUsers() ?? [:]
    @Published var loggedInUser: User? = UserDefaults.standard.loadLoggedInUser()
    @Published var showLoginPopup: Bool = false

    init() {
        // Check if no user is logged in and show login popup
        if loggedInUser == nil {
            showLoginPopup = true
        }
    }

    func toggleDarkMode() {
        isDarkMode?.toggle()
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }

    func saveState() {
        UserDefaults.standard.saveUsers(users)
        if let loggedInUser = loggedInUser {
            UserDefaults.standard.saveLoggedInUser(loggedInUser)
        }
    }
}
