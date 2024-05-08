//
//  RegistrationView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 29.03.2024.
//

import SwiftUI
import Foundation

struct RegistrationView: View {
    
    @State private var fullname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirm_password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
        
            ZStack {
                WaveBackground(waveOpacity: 0.05)
                
                VStack {
                    // ----- logo -----
                    Image("logo-docscan-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
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
                        
                        
                        VStack(alignment: .leading, spacing: 5){
                            HStack{
                                Text("Your password must contain at least:")
                                    .padding(.leading, 20)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            Group{
                                Text("• 7 characters")
                                    .foregroundColor((password.count >= 7) ? Color.passwordGreen : .gray)
                                Text("• 1 number")
                                    .foregroundColor((containsNumberRegex(password)) ? Color.passwordGreen : .gray)
                                Text("• 1 special character (! @ # $ % ^ & *)")
                                    .foregroundColor((containsSpecialCharacterRegex(password)) ? Color.passwordGreen : .gray)

                            }.padding(.leading, 60)
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
                    
                }
            }
            
        }
        
    }
}

func containsNumberRegex(_ password: String) -> Bool {
    // function that determines if a string contains at least 1 number as a character
    
    let regex = try! NSRegularExpression(pattern: "\\d", options: [])
    let matches = regex.numberOfMatches(in: password, range: NSRange(location: 0, length: password.count))
    
    return matches > 0
}

func containsSpecialCharacterRegex(_ password: String) -> Bool {
    // function that determines if a string contains at least 1 special character (!@#$%^&*)
    
    let regex = try! NSRegularExpression(pattern: "[!@#$%^&*]", options: [])
    let matches = regex.numberOfMatches(in: password, range: NSRange(location: 0, length: password.count))
    
    return matches > 0
}

extension RegistrationView: AuthentificationFormProtocol {
    var formIsValid: Bool {
        return
        !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count >= 7 &&
        containsNumberRegex(password) &&
        containsSpecialCharacterRegex(password) &&
        confirm_password == password
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
