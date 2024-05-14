//
//  ScannerView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 27.03.2024.
//

import SwiftUI
import VisionKit
import FirebaseStorage

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

    @EnvironmentObject var viewModel: AuthViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            completion: completionHandler,
            scannedImagesHandler: scannedImagesHandler,
            viewModel: viewModel
        )
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
        private let scannedImagesHandler: ScannedImagesHandler
        private let viewModel: AuthViewModel

        init(completion: @escaping ([String]?) -> Void, scannedImagesHandler: ScannedImagesHandler, viewModel: AuthViewModel) {
            self.completionHandler = completion
            self.scannedImagesHandler = scannedImagesHandler
            self.viewModel = viewModel
        }
        
        
        func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            
            recognizer.recognizeText(withCompletionHandler: completionHandler)
            
            // ------ creating the array of scanned images ------
            for pageNumber in 0..<scan.pageCount {
                let image = scan.imageOfPage(at: pageNumber)

                // ------ uploading an image ------
                uploadImage(withImage: image,
                            withDirname: "upload1",
                            withIndex: pageNumber)
                
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
        
        // TODO: need to restructure the db and filenames
        func uploadImage(withImage imageUpload: UIImage, 
                         withDirname saveDirname: String,
                         withIndex saveIndex: Int) {
            if let imageData = imageUpload.jpegData(compressionQuality: 1) {
                let storage = Storage.storage()
                
                var userId = viewModel.currentUser?.id
                
                storage.reference().child("\(userId!)/\(saveDirname)/\(saveIndex).jpg").putData(imageData, metadata: nil) {
                    (_, err) in
                    if let err = err {
                        print ("error occured: \(err)")
                    } else {
                        print("haha yes")
                    }
                }
            }
        }
        
//        func uploadPhoto(withImage uploadImage: UIImage) {
//            
//            // ------- making sure that the image is valid -------
//    //        guard uploadImage != nil else {
//    //            return
//    //        }
//            
//            print("uploaded")
//            
//            // ------- creating storage reference -------
//            let storageReference = Storage.storage().reference()
//            
//            // ------- turning our image into data -------
//            let imageData = uploadImage.jpegData(compressionQuality: 0.8)
//            
//            guard imageData != nil else {
//                return
//            }
//            
//            let fileReference = storageReference.child("images/\(UUID().uuidString).jpg")
//            
//            // ------- uploading that data -------
//            let uploadTask = fileReference.putData(
//                imageData!,
//                metadata: nil) { metadata, error in
//                
//                    if error == nil && metadata != nil {
//                        // ------- save a reference in the firestore DB -------
//                    }
//            }
//            
//            print("success")
//            
//            // ------- saving a reference to that data in firestore -------
//                
//        }
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
