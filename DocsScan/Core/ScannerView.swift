//
//  ScannerView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 27.03.2024.
//

import SwiftUI
import VisionKit

class ScannedImagesHandler: NSObject {
    var scannedImages: [UIImage] = []
    
    func addScannedImage(_ image: UIImage) {
        scannedImages.append(image)
    }
    
    func resetScannedImage() {
        scannedImages.removeAll()
    }
}


struct ScannerView: UIViewControllerRepresentable {
    
    let scannedImagesHandler = ScannedImagesHandler()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            completion: completionHandler,
            scannedImagesHandler: scannedImagesHandler
        )
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
        private let scannedImagesHandler: ScannedImagesHandler
        
        init(completion: @escaping ([String]?) -> Void, scannedImagesHandler: ScannedImagesHandler) {
            self.completionHandler = completion
            self.scannedImagesHandler = scannedImagesHandler
        }
        
        
        func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            
            recognizer.recognizeText(withCompletionHandler: completionHandler)
            
            // ------ creating the array of scanned images ------
            for pageNumber in 0..<scan.pageCount {
                let image = scan.imageOfPage(at: pageNumber)

                scannedImagesHandler.addScannedImage(image)
                print(image)
            }
            
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            completionHandler(nil)
        }
        
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = VNDocumentCameraViewController
    
    private let completionHandler: ([String]?) -> Void
    
    init(completionHandler: @escaping ([String]?) -> Void) {
        self.completionHandler = completionHandler
    }
}

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
