
import SwiftUI

// TODO: change the width of the singin button and the field forms
// TODO: find a better design for the background
// TODO: check for the implementation of loggining in with google/apple

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
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
                    
                    VStack {
                        // ----- form fileds -----
                        VStack {
                            InputView(
                                text: $email,
                                title: "Email Address",
                                placeHolder: "example@email.com",
                                isSeculreField: false)
                            .autocapitalization(.none)
                            
                            InputView(
                                text: $password,
                                title: "Password",
                                placeHolder: "Enter your password",
                                isSeculreField: true)
                            .autocapitalization(.none)
                        }
                        .padding(.horizontal)
                        //                    .padding(.top, 24)
                        
                        // ----- sign in button -----
                        Button (
                            action: {
                                Task {
                                    print("test")
                                    try await viewModel.signIn(withEmail: email, password: password)
                                }
                            }, label: {
                                HStack{
                                    Text("Sign in")
                                    Image(systemName: "arrow.right")
                                }
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            }
                        )
                        .background(Color.mainBlue)
                        .cornerRadius(10)
                        .disabled(formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        
                        Spacer()
                        
                        // ----- sign up button -----
                        NavigationLink(
                            destination: {
                                RegistrationView()
                                    .navigationBarBackButtonHidden(false)
                            },
                            label: {
                                HStack() {
                                    Text("Don't you have an account ?")
                                    Text("Sign up").bold()
                                }
                            }
                        )
                    }
                }
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
