//
//  ContentView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 26.03.2024.
//

import SwiftUI
import UniformTypeIdentifiers

//struct ContentView2: View {
//    @EnvironmentObject var viewModel: AuthViewModel
//    
//    var body: some View {
//        Group {
//            if $viewModel.userSession != nil {
//                MainScreen()
//            } else {
//                LoginView()
//            }
//        }
//    }
//}



struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
//        if viewModel.currentUser != nil {
//            MainScreen()
//        } else {
//            HomeScreen()
//        }
        HomeScreen()
//        PullingImagesView()
        
    }
}





#Preview {
    ContentView()
}
