//
//  ScanData.swift
//  DocsScan
//
//  Created by Vlad Tomici on 26.03.2024.
//

import Foundation
import VisionKit

struct ScanData: Identifiable {
    var id = UUID()
    var date: String
    let text_content: String
//    let scan_images: VNDocumentCameraScan
    
    init(text_content: String/*, scan_images: VNDocumentCameraScan*/) {
        self.text_content = text_content
//        self.scan_images = scan_images
        self.date = Date().formatted()
    }
}


// ---------------------------------------
// README:
// we are trying here to take the apple scan and convert it into jpeg / png images for showing
//
// but maybe there is a possible implementation of just showing the scan in the app
//
// and maybe in the future we can implement the posibility of exporting the scan to images or pdf
// ---------------------------------------
// public func fromScanToImages (scans: [VNDocumentCameraScan]) {
//    /**
//            Function that transforms the scan into images for showing
//     */
//    var scanned_images: [ImageResource] = []
//    
//    ForEach(scans) { scan in
//        guard let imageData = documentScan.imageOfPage(at: 0)?.jpegData(compressionQuality: 1.0) else {
//            print("Failed to extract image data from VNDocumentCameraScan.")
//            return
//        }
//
//        let imageResource = ImageResource(data: imageData)
//        scanned_images.append(imageResource)
//    }
//    
//    return scanned_images
// }
