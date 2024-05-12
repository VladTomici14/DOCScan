//
//  SettingsRowView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 01.04.2024.
//

import SwiftUI

struct SettingsRowView: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
        }
        
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "settings", tintColor: Color(.systemGray))
}
