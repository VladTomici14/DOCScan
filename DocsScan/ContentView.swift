//
//  ContentView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 26.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showScannerSheet = false;
    @State private var scans:[ScanData] = []
//    @State private var scannedImagesHandler = ScannedImagesHandler()
        
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
//                                        Text("\(scannedImagesHandler.scannedImages.count)")
                                        Text(scan.text_content).padding()
                                    }
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
            .navigationTitle("DOCScan")
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

#Preview {
    ContentView()
}
