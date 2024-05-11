//
//  InputView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 29.03.2024.
//

// TODO: dont you have an account ?????

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeHolder: String
    var isSeculreField = false
    
    var body: some View {

        VStack (alignment: .leading, spacing: 12) {
            Text(title)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSeculreField {
                SecureField(placeHolder, text: $text).font(.system(size: 14))
            } else {
                TextField(placeHolder, text: $text).font(.system(size: 14))
            }
        }
        
    }
}


struct InputView_Previews: PreviewProvider {
    
    static var previews: some View {
        InputView(
            text: .constant(""),
            title: "Email Address",
            placeHolder: "name@.com"
        )
    }
}

#Preview {
    InputView_Previews() as! any View
}
