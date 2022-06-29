//
//  PokemonService.swift
//  Pokemon
//
//  Created by Vivek Virani on 26/06/22.
//

import Foundation
import Alamofire

protocol PokemonServiceProtocol {
    func getPokemons(for page: String?, completion: @escaping (_ success: Bool, _ results: Pokemon?, _ error: String?) -> ())
}

class PokemonService: PokemonServiceProtocol {
    func getPokemons(for page: String?, completion: @escaping (Bool, Pokemon?, String?) -> ()) {
        var requestURL = Constant.pokemonAPI
        if let page = page {
            requestURL = page
        }
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? requestURL
        print(requestURL)
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
