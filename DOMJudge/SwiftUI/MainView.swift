//
//  MainView.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 11.09.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundStyle(.tint)
        
        Text("Hello, World!")
        
        NavigationStack {
            TabView{
                Tab("Home", systemImage: "house"){
                    MainView()
                }
                Tab("Account", systemImage: "person"){
                    AccountView()
                }
            }
            
        }
    }
}

#Preview {
    MainView()
}

