// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import Foundation

protocol PlanetDataSource {
    func getAllPlanets() async throws -> [Planet]
    func deletePlanet(id: String) async throws -> Bool
}
