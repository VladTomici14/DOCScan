//
//  ContentView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 26.03.2024.
//

import SwiftUI
import UniformTypeIdentifiers

//struct ContentView2: View {
//    @EnvironmentObject var viewModel: AuthViewModel
//    
//    var body: some View {
//        Group {
//            if $viewModel.userSession != nil {
//                MainScreen()
//            } else {
//                LoginView()
//            }
//        }
//    }
//}



struct ContentView: View {
    
    @StateObject var viewModel = AuthViewModel()
    
    
    var body: some View {
        HomeScreen()
            .environmentObject(viewModel)
    }
}

struct MainScreen: View {
    @State private var showScannerSheet = false;
    @State private var scans:[ScanData] = []
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
    var imageView: UIImageView!
    var body: some View {
        
        NavigationView {
        
            VStack {
                if scans.count > 0 {
                    List {
                        // TODO: this should use a ForEach for creating the List
                        ForEach (scans) { scan in NavigationLink(
                            destination: {
                                ScrollView {
                                    
                                    // ------- scan text content -------
                                    Text(scan.text_content)
                                        .padding()
                                        .textSelection(.enabled)
                                    
                                    // ------- copy text button -------
                                    CopyAnimation()
                                        .onTapGesture() {
                                            let clipboard = UIPasteboard.general
                                            clipboard.setValue(scan.text_content, forPasteboardType: UTType.plainText.identifier)
                                        }
                                    
                                    // ------- images from the scan -------
                                    var images = ["ss-corect","ss-2","ss-3", "ss-4", "ss-5", "ss-6", "ss-7"]
                                    // TODO: regarding the size of the scans, we can make a thing for the ImageSlideView either to be landscape or portrait (depends on how many pictures were took landscape or portrait moded
                                    ImageSliderView(images: images).ignoresSafeArea().frame(height: 600)
                                
                                    
                                    
                                }.navigationTitle(scan.date)
                            
                            },
                            label: {
                                // TODO: format date in a more beautiful way
                                
                                //                                    Text(Utils.formatDate(scan.date)).lineLimit(1).bold()
                                Text(scan.date).lineLimit(1).bold()
                            }
                        )
                        }
                    }
                } else {
                    Text("No scan done yet!").font(.title)
                }
            }
//            .navigationTitle()
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Image("logo-docscan-white")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .padding()
                }
            }
            .navigationBarItems(
                trailing:
                    Button(
                        action: {
                            self.showScannerSheet = true;
                        },
                        label: {
                            Image(systemName: "person.circle")
                                .font(.largeTitle)
                        }
                    )
                    .sheet(isPresented: $showScannerSheet, content: {
                        makeScannerView()
                    })
            )
        }
        Button(
            action: {
                self.showScannerSheet = true;
            },
            label: {
                HStack {
                    Image(systemName: "doc.on.doc")
                    Text("Scan your document")
                }
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(.blue)
                .cornerRadius(CORNER_RADIUS)
                
            }
        )
        .sheet(isPresented: $showScannerSheet, content: {
            makeScannerView()
        })
        .padding()
        .frame(width: .infinity, height: 50)
        
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
    private var images_paths: [String] = []
    @State private var selection = 0
    
    init (images: [String]) {
        self.images_paths = images
    }
    
    var body: some View {
        
        ZStack {
            
            TabView(selection: $selection) {
                ForEach (0..<images_paths.count) { i in
                    Image("\(images_paths[i])")
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
    ContentView()
}
