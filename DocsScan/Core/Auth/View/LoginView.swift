
import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var showForgottenPasswordView = false
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
                        .padding(.bottom)
                    
                    VStack(spacing: 24) {
                        // ----- form fileds -----
                        InputView(
                            text: $email,
                            title: "Email Address",
                            placeHolder:   "example@email.com",
                            isSeculreField: false)
                        .autocapitalization(.none)
                            
                        InputView(
                            text: $password,
                            title: "Password",
                            placeHolder: "Enter your password",
                            isSeculreField: true)
                        .autocapitalization(.none)
                        
                        // ----- password forgotten button -----
                        Button {
                            showForgottenPasswordView.toggle()
                        } label: {
                            Text("Forgot your password?")
                                .fontWeight(.semibold)
                                .font(.footnote)
                                .foregroundColor(Color.mainBlue)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                        }.sheet(isPresented: $showForgottenPasswordView,
                                content: {
                            ForgotPasswordView()
                        })
                        
                        // ----- sign in button -----
                        Button {
                            Task {
                                print("test")
                                try await viewModel.signIn(withEmail: email, password: password)

                            }
                        } label: {
                            HStack {
                                Text("Sign in")
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity, minHeight: 52)
                            .background(Color.mainBlue)
                            .cornerRadius(15.0)
                        }
                        

//                        Button (
//                            action: {
//                                Task {
//                                    print("test")
//                                    try await viewModel.signIn(withEmail: email, password: password)
//                                }
//                            }, label: {
//                                HStack{
//                                    Text("Sign in")
//                                    Image(systemName: "arrow.right")
//                                }
//                                .bold()
//                                .foregroundColor(.white)
//                                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
//                            }
//                        )
//                        .background(Color.mainBlue)
//                        .cornerRadius(10)
//                        .disabled(formIsValid)
//                        .opacity(formIsValid ? 1.0 : 0.5)
                        
                        Spacer()
                        
                        // ----- sign up button -----
                        NavigationLink(
                            destination: {
                                RegistrationView()
                                    .navigationBarBackButtonHidden(false)
                            },
                            label: {
                                HStack() {
                                    Text("Don't have an account ?")
                                    Text("Sign up")
                                        .bold()
                                }.foregroundColor(Color.mainBlue)
                            }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
    }
}

extension LoginView: AuthentificationFormProtocol {
    
    var formIsValid: Bool {
        return 
        !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count > 6
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
