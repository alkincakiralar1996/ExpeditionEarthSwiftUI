// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import ExpeditionEarthAPI

extension FragmentPlanet {
    func toPlanet() -> Planet {
        return Planet(id: self.id ?? "",
                      name: self.name ?? "",
                      oxygen: self.oxygen ?? 0.0,
                      distance: self.distance ?? 0,
                      lightYears: self.lightYears ?? 0.0,
                      image: self.image ?? "",
                      mAh: self.mAh ?? 0.0
        )
    }
}
