//
//  LoginView.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 12.09.2024.
//

import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}



// Custom placeholder modifier for TextField
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}




struct LoginView: View {
    var user : User = User(id: UUID(), username: "", password: "", email: "")
    
    var body: some View {
        List{
            HStack {
                TextField("Email", text: .constant(user.email))
                    .placeholder(when: user.email.isEmpty) {
                                    Text("example@example.com").foregroundColor(.gray)
                                }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(Color.black)  // Regular text color
                                .keyboardType(.default)  // Avoid using .emailAddress to prevent highlighting
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding()
            }
            HStack {
                SecureInputView("Password", text: .constant(user.password))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
        }
    }
}

#Preview {
    LoginView()
}
