//
//  User.swift
//  DocsScan
//
//  Created by Vlad Tomici on 01.04.2024.
//

import SwiftUI

struct User: Identifiable, Codable {
    
    let id: String
    let fullname: String
    let email: String
    

    var initials: String {
        /**
         Function for extracting initials from the fullname
         */
        
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
    
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Marian Bogdan", email: "bogalima6@gmail.com")
}
