//
//  ForgotPasswordView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 12.05.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var recoveryEmail = ""
    @EnvironmentObject var viewModel: AuthViewModel

    
    var body: some View {

        ZStack {
            
            WaveBackground(waveOpacity: 0.05)
            
            VStack {
                Text("Enter your recovery email")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                VStack(spacing: 24) {
                    // ----- recovery email input field -----
                    InputView(
                        text: $recoveryEmail,
                        title: "Recovery email",
                        placeHolder:   "example@email.com",
                        isSeculreField: false)
                    .autocapitalization(.none)
                    
                    // ----- send recovery email button -----
                    Button {
                        Task {
                            print("have sent recovery email to")
                            try await viewModel.sendRecoveryEmail(withEmail: recoveryEmail)

                        }
                    } label: {
                        HStack {
                            Text("Send recovery email")
                            Image(systemName: "arrow.uturn.left")
                        }.foregroundColor(Color.mainBlue)
                    }

                    
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .padding(.top)
        }
    }
}

#Preview {
    ForgotPasswordView()
}
