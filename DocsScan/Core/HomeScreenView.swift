//
//  HomeScreen.swift
//  DocsScan
//
//  Created by Vlad Tomici on 27.03.2024.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack(alignment: .center) {
                        
            TitleView()
            
            InformationContainerView()
            
            Spacer(minLength: 30)
            
            Button(action: {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }) {
                Text("Continue")
                    .customButton()
            }
            
                
        }.padding(.horizontal)
    }
    
}

struct InformationDetailView: View {
    var subTitle: String = "subtitle"
    var icon: String = "car"
    @State private var animationCount = 0
    
    var body: some View {
        
        HStack(alignment: .center) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(Color.mainBlue)
                .frame(width: 50, alignment: .center)
                .padding(7)
                .accessibility(hidden: true)
            
            Text(subTitle)
                .font(.body)
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .padding(.top)
    }
}

struct InformationContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InformationDetailView(
                subTitle: "Maximize efficiency: automate text extraction, improve organization, optimize storage.",
                icon: "gearshape.2.fill")
            
            InformationDetailView(
                subTitle: "Boost accessibility: streamline access to diverse information and swiftly search scanned documents for specific data",
                icon: "figure.run.circle.fill")
            
            InformationDetailView(
                subTitle: "Decrease dependence on paper documents, aiding environmental preservation.",
                icon: "tree.fill")
                
        }.padding(.horizontal)
    }
}

struct TitleView: View {
    
    var body: some View {

        Image("icon-docscan-transparent-bg")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, alignment: .center)
            .accessibility(hidden: true)
    
        Text("Welcome to")
            .font(.title)
            .bold()
            .padding(-10)
            .multilineTextAlignment(.center)
        
        Image("logo-docscan-blue")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, alignment: .center)
            .accessibility(hidden: true)
            .padding(.bottom)
        
        Text("Simplifying mobile  document management!")
            .font(.title)
            .bold()
            .padding(-10)
            .multilineTextAlignment(.center)
        
    }
    
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.mainBlue)
            )
            .padding(.bottom)
    }
}

extension View {
    func customButton() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}

extension Text {
    func customTitleText() -> Text {
        self
            .fontWeight(.black)
            .font(.system(size: 36))
    }
}

#Preview {
    HomeScreen()
}
