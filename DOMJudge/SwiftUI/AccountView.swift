//
//  AccountView.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 11.09.2024.
//

import SwiftUI

struct AccountView: View {
    @Binding var loggedInUser: User?  // Bind to update the logged-in user status
    @Binding var showLoginPopup: Bool  // To control showing the login modal again

    var body: some View {
        VStack {
            Image(systemName: "person")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Username: \(loggedInUser?.username ?? "Unknown")")
            Text("Email: \(loggedInUser?.email ?? "Unknown")")
            
            Button(action: {
                handleSignOut()  // Sign out logic
            }) {
                HStack {
                    Image(systemName: "person.fill.xmark")
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
    }

    // Handle sign-out logic
    func handleSignOut() {
        // Clear the logged-in user from UserDefaults
        UserDefaults.standard.removeLoggedInUser()
        
        // Clear the loggedInUser binding
        loggedInUser = nil
        
        // Show the login popup again
        showLoginPopup = true
    }
}

#Preview {
    AccountView(loggedInUser: .constant(User(id: UUID(), username: "jan.drobilek", password: "password", email: "email@example.com")), showLoginPopup: .constant(false))
}
