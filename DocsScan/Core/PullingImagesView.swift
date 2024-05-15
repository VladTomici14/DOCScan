//
//  PullingImagesView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 15.05.2024.
//

import SwiftUI
import FirebaseStorage

struct PullingImagesView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var fileList: [String] = []


    var body: some View {
        Text("test")
        List (fileList, id: \.self) { filename in
            Text(filename)
        }.onAppear {
            fetchFilesFromStorage()
        }
        
        Image(uiImage: pullImages)
    }

    
    func fetchFilesFromStorage() {
        
        let storageReference = Storage.storage().reference().child("jM2ONNcTCfgm1cnq7fmid719O0i2/")
        
        print("[StorageReference]: \(storageReference)")
        
        storageReference.listAll { (result, error) in
            if let error = error {
                print("[ERROR]: error in listing the files -> \(error)")
                return
            }
            
            self.fileList = (result?.items.map { $0.name })!
            
        }
        
        print("[FETCHED FILES FROM DB]: \(self.fileList)")
        
        
    }
    
    
    var pullImages: UIImage {
        
        var image: UIImage = UIImage()

        
        
        var userId = "jM2ONNcTCfgm1cnq7fmid719O0i2"
        // Create a reference to the file you want to download

        let islandRef = Storage.storage().reference(forURL: "gs://docscan-ba697.appspot.com/jM2ONNcTCfgm1cnq7fmid719O0i2/upload1/1.jpg")
        
        print ("[ISLAND REFERENCE]: \(islandRef)")

        
                
        islandRef.getData(maxSize: 1 * 4000 * 4000) { data, error in
          if let error = error {
              print("error: \(error)")
          } else {
              print("AICI: \(data!)")
              let imageData = data
              image = UIImage(data: imageData!)!
                    
          }
        }
        
        print("[IMAGE]: \(image.size)")
        
        return image
        
//        storageReference.listAll { result, error in
//            if let error = error {
//                print("Error fetching images from db")
//            } else {
//
//                for item in result!.items {
//                    item.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                        if let error = error {
//                            print("failed to process images")
//                        } else {
//                            if let imageData = data, let image = UIImage(data: imageData) {
//                                print (imageData)
//                                DispatchQueue.main.async {
//                                    imageString.append(image)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
    }
}

#Preview {
    PullingImagesView()
}
