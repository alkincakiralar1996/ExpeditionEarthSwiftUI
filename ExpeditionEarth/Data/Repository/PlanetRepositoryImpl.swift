// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

struct PlanetRepositoryImpl: PlanetRepository {
    @Inject
    private var dataSource: PlanetDataSource
    
    func getPlanets() async throws -> [Planet] {
        let _planets = try await dataSource.getAllPlanets()
        
        try? await Task.sleep(until: .now + .seconds(0.5), clock: .continuous)
        
        return _planets
    }
    
    func deletePlanet(id: String) async throws -> Bool {
        return try await dataSource.deletePlanet(id: id)
    }
}
