// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import Foundation

protocol DeletePlanet {
    func execute(id: String) async -> Result<Bool, UseCaseError>
}

struct DeletePlanetUseCase: DeletePlanet {
    @Inject
    private var repo: PlanetRepository
    
    func execute(id: String) async -> Result<Bool, UseCaseError> {
        do {
            let deletePlanetResult = try await repo.deletePlanet(id: id)
            return .success(deletePlanetResult)
        } catch(let error) {
            switch error {
                default:
                    return .failure(.networkError)
            }
        }
    }
}
