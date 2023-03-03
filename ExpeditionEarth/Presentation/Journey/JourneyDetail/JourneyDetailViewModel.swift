// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/

import SwiftUI

@MainActor
class JourneyDetailViewModel: ObservableObject {
    enum JourneyDetailViewState {
        case loading
        case loaded
        case failure(error: String)
    }

    @Inject
    private var getPlanetsUseCase: GetPlanets

    @Inject
    private var deletePlanetUseCase: DeletePlanet

    @Published var planets: [Planet] = []

    @Published var selectedDeletedPlanet: Planet?
    @Published var selectedPlanet: Planet?
    
    @Published var uiState: JourneyDetailViewState = .loading

    func getPlanets() async {
        uiState = .loading
        
        planets.removeAll()
        selectedPlanet = nil
        
        let result = await getPlanetsUseCase.execute()
        
        switch result {
            case let .success(planets):
                uiState = .loaded

                self.planets = planets
                if !self.planets.isEmpty { selectedPlanet = self.planets[0] }
            case let .failure(error):
                uiState = .failure(error: error.localizedDescription)
        }
    }

    func removePlanet() async {
        guard let selectedDeletedPlanet else { return }

        let result = await deletePlanetUseCase.execute(id: selectedDeletedPlanet.id)
        
        switch result {
            case let .success(success):
                if success {
                    if let planetIndex = planets.firstIndex(where: { $0.id == selectedDeletedPlanet.id }) {
                        withAnimation {
                            self.planets.remove(at: planetIndex)

                            if self.selectedPlanet?.id == selectedDeletedPlanet.id {
                                self.selectedPlanet = !self.planets.isEmpty ? self.planets.first! : nil
                            }

                            self.selectedDeletedPlanet = nil
                        }
                    }
                }
            case let .failure(error):
                self.selectedDeletedPlanet = nil
                uiState = .failure(error: error.localizedDescription)
        }
    }
}
