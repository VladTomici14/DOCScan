//
//  ProfileView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 01.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        // ----- profile pic -----
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }
                
                Section ("General") {
                    HStack {
                        SettingsRowView(
                            imageName: "gear",
                            title: "Version",
                            tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section ("Account") {
                    
                    // ------- sign out button -------
                    Button {
                        dismiss()
                        viewModel.signOut()
                    }  label: {
                        SettingsRowView(
                            imageName: "arrow.left.circle.fill",
                            title: "Sign Out",
                            tintColor: Color(.red))
                    }
                    
                    // ------- delete account -------
                    // TODO: think about account deletion
//                    Button {
//                        print("deleting account")
//                        viewModel.deleteAccount()
//                    }  label: {
//                        SettingsRowView(
//                            imageName: "trash.fill",
//                            title: "Delete account",
//                            tintColor: Color(.systemRed))
//                    }
//                    
                }
                
            }
        }
        
    }
}

#Preview {
    ProfileView()
}
