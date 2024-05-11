//
//  HomeScreen.swift
//  DocsScan
//
//  Created by Vlad Tomici on 27.03.2024.
//

import SwiftUI

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

struct HomeScreen: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                WaveBackground(waveOpacity: 0.05)
                
                VStack(alignment: .center) {
                    
                    TitleView()
                    
                    InformationContainerView()
                    
                    Spacer(minLength: 30)
                    
                    NavigationLink(
                        destination: {
                            
                            Group {
                                if viewModel.userSession != nil {
                                    MainScreen()
                                } else {
                                    LoginView().navigationBarBackButtonHidden(true)

                                }
                            }
                            
                        },
                        label: {
                            Text("Continue")
//                            Text("Continuă")
                                .customButton()
                        }
                    )
                    
                    ShowCurrentUser(viewModel: viewModel)
                    
                }.padding(.horizontal)
            }
        }
    }
    
}

struct ShowCurrentUser: View {
    
    var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.currentUser != nil {
            Text("Welcome back \(viewModel.currentUser?.fullname)")
                .font(.subheadline)
                .foregroundColor(.green)
        } else {
            Text("No user logged in!")
                .font(.subheadline)
                .foregroundColor(.red)
        }
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
//                subTitle: "Maximizarea eficienței: extracție de text automată, dezvoltarea organizării, optimizarea stocării.",
                icon: "paperclip")
            
            InformationDetailView(
                subTitle: "Boost accessibility: streamline access to diverse information and swiftly search scanned documents for specific data",
//                subTitle: "Creșterea accesibilității: facilitează accesul la informații și permite căutarea de date specifice din documente.",
                icon: "figure.run.circle.fill")
            
            InformationDetailView(
                subTitle: "Decrease dependence on paper documents, aiding environmental preservation.",
//                subTitle: "Reducerea dependenței de documente pe hârtie, contribuind la conservarea mediului.",
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
//        Text("Bine ați venit pe")
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
//        Text("Simplificarea gestionării de documente pe mobil!")
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

// -------- background wave animation --------
struct WaveBackground: View {
    
    let universalSize = UIScreen.main.bounds
    var waveOpacity: CGFloat = 0.05
    
    @State var isAnimated = false
    
    var body: some View {
        
        ZStack {
            getSinWave(interval: universalSize.width * 1.5, baseline: 65 + universalSize.height / 2, amplitude: 110)
                .foregroundColor(Color.init(red: 0.3, green: 0.6, blue: 1).opacity(waveOpacity))
                .offset(x: isAnimated ? -1 * universalSize.width * 1.5 : 0)
                .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
            
            getSinWave(interval: universalSize.width, baseline: 70 + universalSize.height / 2, amplitude: 200)
                .foregroundColor(Color.init(red: 0.3, green: 0.6, blue: 1).opacity(waveOpacity))
                .offset(x: isAnimated ? -1 * universalSize.width : 0)
                .animation(Animation.linear(duration: 11).repeatForever(autoreverses: false))
            
            getSinWave(interval: universalSize.width * 3, baseline: 95 + universalSize.height / 2, amplitude: 200)
                .foregroundColor(Color.init(red: 0.3, green: 0.6, blue: 1).opacity(waveOpacity))
                .offset(x: isAnimated ? -1 * universalSize.width * 3 : 0)
                .animation(Animation.linear(duration: 4).repeatForever(autoreverses: false))
            
            getSinWave(interval: universalSize.width * 1.2, baseline: 75 + universalSize.height / 2, amplitude: 50)
                .foregroundColor(Color.init(red: 0.3, green: 0.6, blue: 1).opacity(waveOpacity))
                .offset(x: isAnimated ? -1 * universalSize.width * 1.2 : 0)
                .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
            
        }.onAppear() {
            self.isAnimated = true
        }
    }
    
    func getSinWave(
        interval: CGFloat,
        baseline: CGFloat = UIScreen.main.bounds.height / 2,
        amplitude: CGFloat = 100
    ) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: baseline))
            path.addCurve(
                to: CGPoint(x: interval, y: baseline),
                control1: CGPoint(x: interval * (0.35), y: amplitude + baseline),
                control2: CGPoint(x: interval * (0.65), y: -amplitude + baseline)
            )
            path.addCurve(
                to: CGPoint(x: interval * 2, y: baseline),
                control1: CGPoint(x: interval * (1.35), y: amplitude + baseline),
                control2: CGPoint(x: interval * (1.65), y: -amplitude + baseline)
            )
            path.addLine(to: CGPoint(x: interval * 2, y: universalSize.height))
            path.addLine(to: CGPoint(x: 0, y: universalSize.height))
        }
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
