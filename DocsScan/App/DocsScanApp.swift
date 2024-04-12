//
//  DocsScanApp.swift
//  DocsScan
//
//  Created by Vlad Tomici on 26.03.2024.
//

import SwiftUI
import Firebase

@main
struct DocsScanApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView2()
                .environmentObject(viewModel)
                .preferredColorScheme(.dark)
        }
    }
}
