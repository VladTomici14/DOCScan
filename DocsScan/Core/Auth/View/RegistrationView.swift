//
//  RegistrationView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 29.03.2024.
//

import SwiftUI

// TODO: see how strong is your password when you enter it

struct RegistrationView: View {

    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirm_password = ""
//    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        
        NavigationStack {
        
            VStack {
                // ----- logo -----
                Image("ss-7")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.vertical, 32)
                
                // ----- form fileds -----
                VStack(spacing: 24) {
                    InputView(
                        text: $fullname,
                        title: "Fullname",
                        placeHolder: "Ex: Joe Doe",
                    isSeculreField: false)
                    .autocapitalization(.words)
                    
                    InputView(
                        text: $email,
                        title: "Email",
                        placeHolder: "Enter your email",
                        isSeculreField: false)
                    .autocapitalization(.none)
                    
                    InputView(
                        text: $password,
                        title: "Password",
                        placeHolder: "Enter your password",
                        isSeculreField: true)
                    .autocapitalization(.none)
                    
                    ZStack {

                        InputView(
                            text: $confirm_password,
                            title: "Confirm password",
                            placeHolder: "Re-enter your password",
                            isSeculreField: true)
                        .autocapitalization(.none)
                        
                        if !password.isEmpty && !confirm_password.isEmpty {
                            if password == confirm_password {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                        
                    }
                    

                }
                .padding(.horizontal)
                .padding(.top, 24)
                
                // ----- sign up button -----
                Button (
                    action: {
                        Task {
                            try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                        }
                    }, label: {
                        HStack{
                            Text("Sign up")
                            Image(systemName: "arrow.up")
                        }
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                )
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .disabled(formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                Spacer()
                
                // ----- sign up button -----
                NavigationLink(
                    destination: {
//                        dismiss()
                    },
                    label: {
                        HStack(spacing: 2) {
                            Text("Already have an account ?")
                            Text("Sign in").bold()
                        }
                    }
                )
            }
            
        }
        
    }
}

extension RegistrationView: AuthentificationFormProtocol {
    var formIsValid: Bool {
        return
        !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count > 6 &&
        confirm_password == password
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
