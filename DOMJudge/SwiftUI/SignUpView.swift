//
//  SignUpView.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 12.09.2024.
//

import SwiftUI

import SwiftUI

struct SignUpView: View {
    @Binding var showSignUpPopup: Bool  // Controls the visibility of the sign-up modal
    @Binding var showLoginPopup: Bool  // Controls the visibility of the login modal (passed from LoginView)
    @Binding var loggedInUser: User?  // Bind to automatically log in the new user after sign-up
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var signUpError: String?

    var users: [String: User]  // Existing users for validation
    @Binding var updateUsers: [String: User]  // To update users with new accounts
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let error = signUpError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                handleSignUp()
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
    }

    func handleSignUp() {
        // Simple validation
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            signUpError = "All fields are required"
            return
        }

        guard password == confirmPassword else {
            signUpError = "Passwords do not match"
            return
        }
        
        guard !users.keys.contains(username) else {
            signUpError = "Username already exists"
            return
        }

        guard isValidEmail(email) else {
            signUpError = "Invalid email format"
            return
        }
        
        // Create new user
        let newUser = User(id: UUID(), username: username, password: password, email: email)
        updateUsers[username] = newUser  // Add the new user
        
        // Save the new user to UserDefaults
        UserDefaults.standard.saveUsers(updateUsers)

        // Log in the new user
        loggedInUser = newUser
        UserDefaults.standard.saveLoggedInUser(newUser)
        
        // Close the sign-up modal and the login modal
        showSignUpPopup = false
        showLoginPopup = false
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

#Preview {
    SignUpView(showSignUpPopup: .constant(true),showLoginPopup: .constant(false), loggedInUser: .constant(nil), users: [:], updateUsers: .constant([:]))
}
