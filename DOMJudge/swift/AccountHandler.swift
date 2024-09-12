//
//  AccountHandler.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 12.09.2024.
//

import Foundation

class User: Identifiable, Codable {
    var id: UUID
    var username: String
    var password: String
    var email: String

    init(id: UUID, username: String, password: String, email: String) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
    }
    // You might also want to make the password more secure, e.g., hashing it.
    
    func Login(password: String) -> Bool {
        if self.password == password {
            return true
        } else {
            return false
        }
    }
}


extension UserDefaults {
    
    func saveUsers(_ users: [String: User]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(users)
            self.set(data, forKey: "users")
        } catch {
            print("Failed to save users: \(error)")
        }
    }
    
    func loadUsers() -> [String: User]? {
        if let data = self.data(forKey: "users") {
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([String: User].self, from: data)
                return users
            } catch {
                print("Failed to load users: \(error)")
            }
        }
        return nil
    }
}
