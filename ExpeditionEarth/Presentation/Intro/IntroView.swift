// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

struct IntroView: View {
    /* ANIMATION PARAMETERS */
    @State private var displayTopTitle = false
    @State private var displayEarth = false
    @State private var displayEntry = false
    @State private var earthRotatingValue = 0.0

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Expedition\nEarth 2.0")
                        .foregroundColor(.white)
                        .font(.custom("Bebas Neue", size: 67))
                        .shadow(color: .init(hex: "18AAFF"), radius: 0, x: 0, y: 4)
                        .opacity(displayTopTitle ? 1 : 0)
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.leading, 30)
                Spacer()
                HStack {
                    Image("Planet")
                        .frame(width: 0, height: 0)
                        .background(Color.pink)
                        .rotationEffect(.degrees(earthRotatingValue))
                        .opacity(displayEarth ? 1 : 0)
                        .onAppear(perform: {
                            withAnimation(.linear(duration: 1)
                                .speed(0.1).repeatForever(autoreverses: false)) {
                                    earthRotatingValue = 360.0
                                }
                        })
                    Spacer()
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Entry Code")
                            .foregroundColor(.white)
                            .font(.mohave(.semibold, size: 28))
                        NavigationLink {
                            JourneyDetailView()
                        } label: {
                            Image("next_btn")
                        }.buttonStyle(ScaleButtonStyle())
                    }
                    .opacity(displayEntry ? 1 : 0)
                }
                .padding(.trailing, 35)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("launch_screen")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
            .onAppear {
                Task {
                    await animate(duration: 0.5) {
                        displayTopTitle = true
                    }
                    await animate(duration: 0.5) {
                        displayEarth = true
                    }
                    await animate(duration: 0.5) {
                        displayEntry = true
                    }
                }
            }
        }
    }
}

#if DEBUG
    struct IntroView_Previews: PreviewProvider {
        static var previews: some View {
            IntroView()
        }
    }
#endif
