//
//  PDFView.swift
//  DocsScan
//
//  Created by Vlad Tomici on 10.05.2024.
//

import SwiftUI
import PDFKit
import UIKit

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct PDFKitView: View {
    var url: URL = URL(fileURLWithPath: "file:///var/mobile/Containers/Data/Application/A7B3A219-E9AC-4C01-AF28-09E2941A93C7/Documents/Scanned-Docs.pdf")

    var body: some View {
        PDFKitRepresentedView(url)
    }
}

#Preview {
    PDFKitView()
}
