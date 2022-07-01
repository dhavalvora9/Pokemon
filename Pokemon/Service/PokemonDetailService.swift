//
//  PokemonDetailService.swift
//  Pokemon
//
//  Created by Vivek Virani on 30/06/22.
//

import Foundation
import Alamofire

protocol PokemonDetailServiceProtocol {
    func getPokemonDetail(from path: String?, completion: @escaping (_ success: Bool, _ results: PokemonDetail?, _ error: String?) -> ())
}

class PokemonDetailService: PokemonDetailServiceProtocol {
    func getPokemonDetail(from path: String?, completion: @escaping (Bool, PokemonDetail?, String?) -> ()) {
        if let requestURL = path {
            let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? requestURL
            print(requestURL)
            if let reachabilityManager = NetworkReachabilityManager(),
               reachabilityManager.isReachable {
                AF.request(encodedURL, method: .get).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            // Decode JSON data
                            let decodeed = try JSONDecoder().decode(PokemonDetail.self, from: data)
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
        } else {
            completion(false, nil, "Sorry. It's not you. It's us.")
        }
    }
}

