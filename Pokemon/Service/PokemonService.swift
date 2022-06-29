//
//  PokemonService.swift
//  Pokemon
//
//  Created by Vivek Virani on 26/06/22.
//

import Foundation
import Alamofire

protocol PokemonServiceProtocol {
    func getPokemons(forPage: String?, completion: @escaping (_ success: Bool, _ results: Pokemon?, _ error: String?) -> ())
}

class PokemonService: PokemonServiceProtocol {
    func getPokemons(forPage: String?, completion: @escaping (Bool, Pokemon?, String?) -> ()) {
        let requestURL = Constant.pokemonAPI
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? requestURL
        
        if let reachabilityManager = NetworkReachabilityManager(),
           reachabilityManager.isReachable {
            AF.request(encodedURL, method: .get).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        // Decode JSON data
                        let decodeed = try JSONDecoder().decode(Pokemon.self, from: data)
                        completion(true, decodeed, nil)
                    } catch {
                        completion(false, nil, "Sorry. It's not you. It's us.")
                    }
                case .failure(let error):
                    print(error)
                    completion(false, nil, error.errorDescription)
                }
            }
        } else {
            completion(false, nil, "The Internet connection appears to be offline.")
        }
    }
}
