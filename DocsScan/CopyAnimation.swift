//
//  TestingAnimations.swift
//  DocsScan
//
//  Created by Vlad Tomici on 28.03.2024.
//

import SwiftUI

struct CopyAnimation: View {
    
    let streamBlue = Color(#colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1))
    @State private var copyText: String = "Copy"
    @State private var copyTextColor = Color(.systemGray)

    
    @State private var copyIcon = Image(systemName: "doc.on.doc")
    @State private var removeInnerStroke = false
    @State private var showHeart = false
    @State private var showSplash = false
    @State private var removeSplash = false


    
    var body: some View {
        
        Text("Copy").font(.title)
        
        HStack {
            ZStack {
                copyIcon
                    .font(.largeTitle)
                    .foregroundColor(Color(.systemGray))
                
                // ----- inner stroke -----
                Circle()
                    .strokeBorder(lineWidth:  removeInnerStroke ? 0 : 35)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.systemPink))
                    .scaleEffect(removeInnerStroke ? 1.3 : 0.0)
                    .hueRotation(.degrees(removeInnerStroke ? 270 : 0))
                
                // ----- filled copy -----
                copyIcon
                    .font(.largeTitle)
                    .foregroundColor(streamBlue)
                    .scaleEffect(showHeart ? 1 : 0)

                
                // ----- circular splash -----
                TwitterSplashView()
                    .scaleEffect(showSplash ? 1 : 0)
                    .opacity(removeSplash ? 0 : 1)
                
            }
            .onTapGesture {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 10).delay(0.1)) {
                    showHeart = true
                }
                
                // EaseOut objects that exit the screen
                withAnimation(.easeOut) {
                    showSplash = true
                }
                
                // EaseIn objects that move onscreen
                withAnimation(.easeIn.delay(0.2)) {
                    removeSplash = true
                }
                
                // EaseIn objects that move onscreen
                withAnimation(.easeIn.delay(0.2)) {
                    removeInnerStroke = true
                }
                
                copyText = "Copied"
                copyTextColor = streamBlue
            }.accessibilityAddTraits(.isButton)
            
            Text("\(copyText)")
                .foregroundColor(copyTextColor)
                .font(.title)
            
        }
    
    }
}

struct TwitterContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestingAnimations()
            .preferredColorScheme(.dark)
    }
}

#Preview {
    TestingAnimations()
}
