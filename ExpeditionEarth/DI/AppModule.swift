// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import Swinject

@propertyWrapper
struct Inject<I> {
    let wrappedValue: I
    init() {
        self.wrappedValue = Resolver.shared.resolve(I.self)
    }
}

class Resolver {
    static let shared = Resolver()
    
    private var container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

func buildContainer() -> Container {
    let container = Container()
    
    container.buildUseCases()
    container.buildDataSources()
    container.buildRepositories()
    
    return container
}

extension Container {
    func buildUseCases() {
        self.register(GetPlanets.self) { _  in
            return GetPlanetsUseCase()
        }.inObjectScope(.container)
        
        self.register(DeletePlanet.self) { _  in
            return DeletePlanetUseCase()
        }.inObjectScope(.container)
    }
    
    func buildDataSources() {
        self.register(PlanetDataSource.self) { _  in
            return PlanetDataSourceImpl()
        }.inObjectScope(.container)
    }
    
    func buildRepositories() {
        self.register(PlanetRepository.self) { _  in
            return PlanetRepositoryImpl()
        }.inObjectScope(.container)
    }
}
