// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/

import CachedAsyncImage
import SwiftUI
import Refresher

struct JourneyDetailView: View {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel = JourneyDetailViewModel()

    @State var displayLiveTracking = false
    @State var rocketFrame: CGSize = .init(width: 150, height: 10)
    @State var displayOngoingSection = false
    @State var displayPlanetsSection = false

    @State var flightProgressWidth: CGFloat = 0.0

    fileprivate func buildPlanetsSection() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Schedule next")
                .foregroundColor(.white)
                .font(.mohave(.medium, size: 28))
                .padding(.leading, 12)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(viewModel.planets, id: \.id) { item in
                        PlanetView(planet: item, viewModel: viewModel)
                    }
                }
                .padding(.top, 22)
            }
        }
        .padding(.trailing, -22)
    }

    fileprivate func buildOngoingSection(planet: Planet) -> some View {
        VStack(alignment: .leading) {
            Text("Ongoing")
                .foregroundColor(.white)
                .font(.mohave(.medium, size: 28))
                .padding(.leading, 12)
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Image("rocket_up")
                    Text(planet.id)
                        .font(.mohave(.medium, size: 27))
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("From")
                            .font(.mohave(.medium, size: 16))
                            .foregroundColor(.black)
                        Text("Earth 2.0")
                            .font(.mohave(.semibold, size: 30))
                            .foregroundColor(.black)
                        HStack {
                            Image("oxygen")
                            Text("100%")
                                .font(.mohave(.medium, size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 5) {
                        Text("To")
                            .font(.mohave(.medium, size: 16))
                            .foregroundColor(.black)
                        Text(planet.name)
                            .font(.mohave(.semibold, size: 30))
                            .foregroundColor(.black)
                        HStack {
                            Image("oxygen")
                            Text("\(String(format: "%.1f", planet.oxygen))%")
                                .font(.mohave(.medium, size: 20))
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    Text("Entry Code")
                        .font(.mohave(.medium, size: 16))
                        .foregroundColor(.black)
                    Image("qr")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 16)
            .padding(.leading, 26)
            .padding(.trailing, 26)
            .frame(maxWidth: .infinity)
            .background(
                Image("ticket")
                    .resizable()
            )
        }
    }

    fileprivate func buildLiveTrackingSection() -> some View {
        VStack(spacing: 22) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Live Tracking")
                        .foregroundColor(.white)
                        .font(.mohave(.medium, size: 28))
                    if let selectedPlanet = viewModel.selectedPlanet {
                        Text("Reaching destination : \(selectedPlanet.distance) mins")
                            .foregroundColor(.white)
                            .font(.mohave(.medium, size: 16))
                    }
                }
                Spacer()
            }
            .padding(.leading, 12)
            HStack(alignment: .center, spacing: 15) {
                Image("earth")
                    .frame(width: 42, height: 42)
                VStack {
                    ZStack(alignment: .leading) {
                        VStack {}
                            .frame(maxWidth: .infinity)
                            .frame(height: 5)
                            .background(Color(hex: "9CDBFF"))
                            .cornerRadius(4)
                        GeometryReader { geo in
                            ZStack(alignment: .trailing) {
                                Rectangle()
                                    .stroke(Color(hex: "26AFFF"), lineWidth: 14)
                                    .frame(width: rocketFrame.width, height: 10)
                                    .blur(radius: 15)
                                Image("rocket")
                                    .offset(y: 3)
                            }
                            .onAppear {
                                flightProgressWidth = geo.size.width
                            }
                        }
                    }
                    Spacer().frame(height: 15)
                }
                if let selectedPlanet = viewModel.selectedPlanet {
                    CachedAsyncImage(
                        url: .init(string: selectedPlanet.image),
                        content: { image in
                            image.resizable()
                                .frame(width: 52, height: 52)
                                .offset(y: -5)
                                .shadow(color: .red, radius: 15, y: 3)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
            }
        }
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    switch viewModel.uiState {
                    case .loading:
                        VStack {
                            LottieView(lottieFile: "loading-planets")
                                .frame(width: 300, height: 300)
                        }.frame(width: geometry.size.width)
                            .frame(minHeight: geometry.size.height)
                    case .loaded:
                        VStack(alignment: .leading, spacing: 22) {
                            buildLiveTrackingSection()
                                .opacity(displayLiveTracking ? 1 : 0)
                            if let planet = viewModel.selectedPlanet {
                                buildOngoingSection(planet: planet)
                                    .opacity(displayOngoingSection ? 1 : 0)
                            }
                            buildPlanetsSection()
                                .opacity(displayPlanetsSection ? 1 : 0)
                            Spacer()
                        }
                        .padding(.top, 32)
                        .padding(.leading, 22)
                        .padding(.trailing, 22)
                        .opacity(viewModel.planets.isEmpty ? 0 : 1)
                    case let .failure(error):
                        VStack {
                            LottieView(lottieFile: "404-planets")
                                .frame(width: 300, height: 300)
                            Spacer().frame(height: 12)
                            Text("Failed to loads planets.\n\(error)")
                                .foregroundColor(.white)
                        }.frame(width: geometry.size.width)
                            .frame(minHeight: geometry.size.height)
                    }
                }
                .refresher(refreshView: JourneyRefreshView.init) { done in
                    Task {
                        await viewModel.getPlanets()
                        done()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("detail_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                )
            }
        }
        .navigationTitle("Journey Details")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("back_btn")
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getPlanets()

                await animate(duration: 0.5, {
                    displayLiveTracking = true
                })

                await animate(duration: 0.5, {
                    displayOngoingSection = true
                })

                await animate(duration: 0.5, {
                    displayPlanetsSection = true
                })
            }
        }
        .onReceive(viewModel.$selectedPlanet) { selectedPlanet in
            guard let selectedPlanet else { return }

            withAnimation(.interpolatingSpring(mass: 0.2, stiffness: 0.4, damping: 0.425, initialVelocity: 2.5)) {
                let calculatedWidth = (flightProgressWidth * CGFloat(selectedPlanet.distance)) / 100
                rocketFrame = .init(width: calculatedWidth, height: 0)
            }
        }
        .onReceive(viewModel.$uiState) { uiState in
            switch uiState {
                case .loading, .loaded: rocketFrame = .init(width: 150, height: 10)
                default: break
            }
        }
    }
}

#if DEBUG
    struct JourneyDetailView_Previews: PreviewProvider {
        static var previews: some View {
            JourneyDetailView()
        }
    }
#endif

public struct JourneyRefreshView: View {
    @Binding var state: RefresherState
    @State private var angle: Double = 0.0
    @State private var isAnimating = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 1.0)
            .repeatForever(autoreverses: false)
    }
    
    public var body: some View {
        VStack {
            switch state.mode {
            case .pulling, .notRefreshing:
                Image("earth")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(360 * state.dragPosition))
            case .refreshing:
                Image("earth")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(self.isAnimating ? 360.0 : 0.0))
                        .onAppear {
                            withAnimation(foreverAnimation) {
                                isAnimating = true
                            }
                    }
            }
        }
        .scaleEffect(2)
    }
}
