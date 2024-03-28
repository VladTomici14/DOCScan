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

    
    @State private var copyIcon = Image(systemName: "doc.on.doc.fill")
    @State private var removeInnerStroke = false
    @State private var showCopy = false
    @State private var showSplash = false
    @State private var removeSplash = false


    
    var body: some View {
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
    
    }
}

struct SplashView: View {
    @State private var innerGap = true
    let streamBlue = Color(#colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1))
    
    private let PARTICLE_RADIUS: CGFloat = 5.0
    
    var body: some View {
        ZStack {
            ForEach(0..<8) {
                Circle()
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.green, .red],
                            startPoint: .bottom,
                            endPoint: .leading
                        )
                    )
                    .frame(width: PARTICLE_RADIUS, height: PARTICLE_RADIUS)
                    .offset(x: innerGap ? 26 : 0)
                    .rotationEffect(.degrees(Double($0) * 45))
                    .hueRotation(.degrees(300))
            }
            
            ForEach(0..<8) {
                Circle()
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.green, streamBlue],
                            startPoint: .bottom,
                            endPoint: .leading
                        )
                    )
                    .frame(width: PARTICLE_RADIUS, height: PARTICLE_RADIUS)
                    .offset(x: innerGap ? 30 : 0)
                    .rotationEffect(.degrees(Double($0) * 45))
                    .hueRotation(.degrees(60))
                
            }
            .rotationEffect(.degrees(12))
        }
    }
}


#Preview {
    CopyAnimation()
}
