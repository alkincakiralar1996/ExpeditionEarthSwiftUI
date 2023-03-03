// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import Apollo
import ExpeditionEarthAPI

enum APIServiceError: Error {
    case requestError
}

struct PlanetDataSourceImpl: PlanetDataSource {
    static var ads = 0
    
    func getAllPlanets() async throws -> [Planet] {
        PlanetDataSourceImpl.ads += 1

        return try await withCheckedThrowingContinuation({ continuation in
            client?.fetch(query: ExpeditionEarthAPI.AllPlanetsQuery(), cachePolicy: .fetchIgnoringCacheCompletely) { result in
                guard let data = try? result.get().data else {
                    continuation.resume(throwing: APIServiceError.requestError)
                    return
                }
                
                if PlanetDataSourceImpl.ads == 3 {
                    continuation.resume(throwing: APIServiceError.requestError)
                    return
                }

                continuation.resume(returning:
                    data.planets?.removeNils().map({ $0.fragments.fragmentPlanet.toPlanet() }) ?? []
                )
            }
        })
    }
    
    func deletePlanet(id: String) async throws -> Bool {
        return try await withCheckedThrowingContinuation({ continuation in
            client?.perform(mutation: ExpeditionEarthAPI.DeletePlanetMutation(id: id)) { result in
                guard let data = try? result.get().data else {
                    continuation.resume(throwing: APIServiceError.requestError)
                    return
                }
                
                continuation.resume(returning: data.deletePlanet)
            }
        })
    }
}
