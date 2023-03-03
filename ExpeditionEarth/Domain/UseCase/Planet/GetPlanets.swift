// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import Foundation

enum UseCaseError: Error {
    case networkError
}

protocol GetPlanets {
    func execute() async -> Result<[Planet], UseCaseError>
}

struct GetPlanetsUseCase: GetPlanets {
    @Inject
    private var repo: PlanetRepository
    
    func execute() async -> Result<[Planet], UseCaseError> {
        do {
            let todos = try await repo.getPlanets()
            return .success(todos)
        } catch(let error) {
            switch error {
            default:
                return .failure(.networkError)
            }
        }
    }
}
