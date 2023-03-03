// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import Apollo
import Foundation

let client: ApolloClient? = {
    let cache = InMemoryNormalizedCache()
    let store = ApolloStore(cache: cache)

    let client = URLSessionClient()

    if let infoDictionary = Bundle.main.infoDictionary,
       let serverUrl = infoDictionary["ServerURL"] as? String,
       let url = URL(string: serverUrl) {
        return ApolloClient(url: url)
    }

    return nil
}()
