//
//  MainScreeen.swift
//  DocsScan
//
//  Created by Vlad Tomici on 11.05.2024.
//

import SwiftUI
import FirebaseStorage
import Firebase

struct MainScreen: View {
    @State private var showScannerSheet = false
    @State private var showProfileView = false
    @State private var scans: [ScanData] = []
    @State private var searchText: String = ""
    @State private var isCopied = false {
            didSet {
                if isCopied == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isCopied = false
                        }
                    }
                }
            }
        }
    @EnvironmentObject var viewModel: AuthViewModel

    private let CORNER_RADIUS: CGFloat = 15.0
    var scansNames: [String] = []
    var imageView: UIImageView!
    
    
    var body: some View {
        
        NavigationView {
        
            NavigationStack {
                VStack {
                    if scans.count > 0 {
                        List {
                            ForEach (searchResults) { scan in NavigationLink(
                                destination: {
                                    ScrollView {
                                        
                                        
                                        // ------- scanned text content -------
                                        Text(writeTextToDB(withText: scan.text_content))
                                            .padding()
                                            .textSelection(.enabled)
                                            
                                        
                                        // ------- upload text content to db -------
                                        
                                        
                                        // ------- instructions for text copy -------
//                                        Text("(Hold and press 'Copy' to effortlessly copy text)")
                                        Text("(Tineți apăsat si apăsați 'Copy' pentru copierea textului)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        
                                        // ------- images from the scan -------
//                                        ImageSliderView(images: pullImages)
//                                            .ignoresSafeArea()
//                                            .frame(height: 600)
                                        
                                    }.navigationTitle(scan.date)
                                    
                                },
                                label: {
                                    // ------- label of each scan -------
                                    var scanDate: String = "\(scan.date)"
                                    var scanContent: String = "\(scan.text_content)"
                                    Text("\(scanDate) - \(scanContent)").lineLimit(1).bold()
                                }
                            )
                            }
                        }
                    } else {
//                        Text("No scan done yet!")
                        Text("Nicio scanare efectuată!")
                            .font(.title)
                    }
                }
                .searchable(text: $searchText)
                .sheet(isPresented: $showProfileView, content: {
                    ProfileView(viewModel: _viewModel)
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image("logo-docscan-blue")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        // ----- profile view button -----
                        Button {
                            showProfileView.toggle()
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.mainBlue)
                        }
                        
//                        Button(
//                            action: {
//                                Task {
//                                    print("user signed out")
//                                    viewModel.signOut()
//                                    
//                                }
//                            },
//                            label: {
//                                Image(systemName: "door.left.hand.open")
//                                    .font(.largeTitle)
//                                    .foregroundColor(.red)
//                            }
//                        )
//                        .sheet(isPresented: $showScannerSheet, content: {
//                            makeScannerView()
//                        })
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
        // ----- scan button -----
        Button(
            action: {
                self.showScannerSheet = true;
            },
            label: {
                HStack {
                    Image(systemName: "doc.on.doc")
//                    Text("Scan your document")
                    Text("Scanează un document")
                }
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(Color.mainBlue)
                .cornerRadius(CORNER_RADIUS)
                
            }
        )
        .sheet(isPresented: $showScannerSheet, content: {
            makeScannerView()
        })
        .padding()
        .frame(width: .infinity, height: 50)
        
    }
    
    
    var searchResults: [ScanData] {
        if searchText.isEmpty {
            return scans
        } else {
            return scans.filter { $0.text_content.lowercased().contains(searchText.lowercased()) }
        }
    }
    
//    var pullImages: [UIImage] {
//        let storageReference = Storage.storage().reference().child("\(viewModel.currentUser?.id)/upload1/")
//        
//        var imageString: [UIImage] = []
//        
//        storageReference.listAll { result, error in
//            if let error = error {
//                print("Error fetching images from db")
//            } else {
//                for item in result!.items {
//                    item.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                        if let error = error {
//                            print("failed to process images")
//                        } else {
//                            if let imageData = data, let image = UIImage(data: imageData) {
//                                DispatchQueue.main.async {
//                                    imageString.append(image)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
//        return imageString
//    }

    
    func writeTextToDB(withText text: String) -> String {
        let dbReference = Database.database().reference()
        
        let textReference = dbReference.child("users/\(viewModel.currentUser?.id)/")
        
        textReference.setValue(text) { error, _ in
                    if let error = error {
                        print("Error saving text to database: \(error.localizedDescription)")
                    } else {
                        print("Text saved successfully!")
                    }
                }
        
        print(text)
        
        return text
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(
            completionHandler: { textPerPage in
                if let outputText = textPerPage?
                    .joined(separator: "\n")
                    .trimmingCharacters(in: .whitespacesAndNewlines) {
                    let newScanData = ScanData(
                        text_content: outputText
                    )
                    self.scans.append(newScanData)
                }
                self.showScannerSheet = false
            }
        )
    }
    

    
}

struct ImageSliderView: View {
    /**
     Function for showing the images to the use by sliding.
     */
    private let CORNER_RADIUS: CGFloat = 10.0
    private var uiimages: [UIImage] = []
    @State private var selection = 0
    
    init (images: [UIImage]) {
        self.uiimages = images
    }
    
    var body: some View {
        
        ZStack {
            
            TabView(selection: $selection) {
                ForEach (0..<uiimages.count) { i in
                    Image(uiImage: uiimages[i])
                        .resizable()
                        .frame(width: .infinity)
                        .ignoresSafeArea()
                        .clipShape(RoundedRectangle(cornerRadius: CORNER_RADIUS))
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            .clipShape(RoundedRectangle(cornerRadius: CORNER_RADIUS))
            
        }
        .ignoresSafeArea()
        .padding()
    }
}


#Preview {
    MainScreen()
}
