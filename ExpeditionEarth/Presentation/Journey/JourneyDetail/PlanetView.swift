// Created by Alkın Çakıralar for ExpeditionEarth in 2.03.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI
import CachedAsyncImage

struct PlanetView: View {
    let planet: Planet
    let viewModel: JourneyDetailViewModel
    
    @State var displayDeletePlanetConfirmationAlert = false
    
    var body: some View {
        GeometryReader { geo in
            Button {
            } label: {
                ZStack(alignment: .trailing) {
                    CachedAsyncImage(
                        url: .init(string: planet.image),
                        content: { image in
                            image.resizable()
                                .frame(width: 180, height: 180)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .offset(x: 50, y: -50)
                    .zIndex(1)
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(planet.name)
                                        .font(.mohave(.medium, size: 30))
                                        .foregroundColor(.white)
                                    Text("\(String(format: "%.1f", planet.lightYears))\nlight yrs")
                                        .foregroundColor(.white)
                                        .font(.mohave(.medium, size: 16))
                                }
                            }
                            Spacer()
                            HStack(spacing: 4) {
                                Text("Select")
                                    .foregroundColor(.white)
                                    .font(.mohave(.medium, size: 20))
                                    .shadow(color: .init(hex: "43BAFF").opacity(0.55), radius: 0, x: 0, y: 2)
                                Image("continue")
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white, lineWidth: 2)
                            .overlay(
                                LinearGradient(gradient: Gradient(colors:
                                    [Color(hex: "545454").opacity(0.8), Color(hex: "4C4B4C").opacity(0.55)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                    )
                }
            }
            .buttonStyle(ScaleButtonStyle())
            .rotation3DEffect(
                Angle(
                    degrees: Double((geo.frame(in: .global).minX - 15) / -15)
                ),
                axis: (x: 0, y: 1, z: 0),
                anchor: .center,
                anchorZ: 0.0,
                perspective: 1.0
            )
            .simultaneousGesture(
                LongPressGesture()
                    .onEnded { _ in
                        viewModel.selectedDeletedPlanet = planet
                        self.displayDeletePlanetConfirmationAlert.toggle()
                    }
            )
            .highPriorityGesture(TapGesture()
                .onEnded { _ in
                    withAnimation {
                        viewModel.selectedPlanet = planet
                    }
                })
            .alert(isPresented: self.$displayDeletePlanetConfirmationAlert) {
                Alert(title: Text("Warning"), message: Text("Do you realy want to delete this planet from the list ?"), primaryButton: .default(Text("Delete"), action: {
                    Task {
                        await viewModel.removePlanet()
                    }
                }), secondaryButton: .destructive(Text("Cancel"), action: {
                }))
            }
        }
        .frame(width: 260)
        .frame(height: 180)
        .padding(.top, 15)
        .padding(.bottom, 30)
        .padding(.trailing, 50)
    }
}
