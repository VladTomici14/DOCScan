//
//  ScanData.swift
//  DocsScan
//
//  Created by Vlad Tomici on 26.03.2024.
//

import Foundation

struct ScanData: Identifiable {
    var id = UUID()
    let content: String
    
    init(content: String) {
        self.content = content
    }
}
