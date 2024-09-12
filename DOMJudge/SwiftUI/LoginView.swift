import SwiftUI

struct LoginView: View {
    @Binding var showLoginPopup: Bool  // Controls the visibility of the login modal
    @Binding var loggedInUser: User?
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginError: String?
    
    @State private var showSignUpPopup: Bool = false  // Controls the visibility of the sign-up modal
    @Binding var users: [String: User]  // Pass the users dictionary
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let error = loginError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                handleLogin()
            }) {
                Text("Login")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            
            // Add a sign-up button
            Button(action: {
                showSignUpPopup = true  // Open sign-up modal
            }) {
                Text("Don't have an account? Sign Up")
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .padding()
        .sheet(isPresented: $showSignUpPopup) {
            // Pass the necessary bindings to SignUpView, including the login modal binding
            SignUpView(showSignUpPopup: $showSignUpPopup, showLoginPopup: $showLoginPopup, loggedInUser: $loggedInUser, users: users, updateUsers: $users)
        }
    }

    func handleLogin() {
        // Existing login logic
        if let user = users[username], user.Login(password: password) {
            loggedInUser = user
            UserDefaults.standard.saveLoggedInUser(user)
            showLoginPopup = false  // Close login modal after successful login
        } else {
            loginError = "Invalid username or password"
        }
    }
}
