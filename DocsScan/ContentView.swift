//
//  ContentView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 26.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showScannerSheet = false;
    @State private var texts:[ScanData] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if texts.count > 0 {
                    List {
                        ForEach(texts) { text in NavigationLink(
                            destination: ScrollView {
                                Text(text.content)
                            },
                            label: {
                                Text(text.content).lineLimit(1)
                            }
                        )
                        }
                    }
                } else {
                    Text("No scan done yet!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
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
                            Image(systemName: "doc.text.viewfinder")
                                .font(.title)
                        }
                    )
                    .sheet(isPresented: $showScannerSheet, content: {
                        makeScannerView()
                    })
            )
        }
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completionHandler: {
            textPerPage in
            if let outputText = textPerPage?
                .joined(separator: "\n")
                .trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
}

#Preview {
    ContentView()
}
