import SwiftUI

struct SettingsView: View {
    @Binding var isDarkMode: Bool?  // Binding to dark mode preference

    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Picker("Appearance", selection: Binding(
                    get: {
                        isDarkMode == nil ? "System Default" : (isDarkMode! ? "Dark" : "Light")
                    },
                    set: { newValue in
                        switch newValue {
                        case "System Default":
                            isDarkMode = nil
                        case "Dark":
                            isDarkMode = true
                        case "Light":
                            isDarkMode = false
                        default:
                            isDarkMode = nil
                        }
                    }
                )) {
                    Text("System Default").tag("System Default")
                    Text("Light").tag("Light")
                    Text("Dark").tag("Dark")
                }
                .pickerStyle(SegmentedPickerStyle())  // You can also use .menu or .wheel if you prefer
            }

            Section(header: Text("Account")) {
                HStack {
                    Text("Username")
                    Spacer()
                    Text("jan.drobilek")  // Replace with dynamic user data
                }
                HStack {
                    Text("Email")
                    Spacer()
                    Text("delta.skola.vyvoj@gmail.com").foregroundColor(.blue)  // Replace with dynamic user data
                }
                
                Button(action: {
                    // Sign out logic here
                }) {
                    HStack {
                        Image(systemName: "person.fill.xmark")
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(isDarkMode: .constant(nil))  // nil means system default
}
