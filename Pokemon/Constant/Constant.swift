//
//  Constant.swift
//  Pokemon
//
//  Created by Vivek Virani on 26/06/22.
//

import Foundation

struct Constant {
    private struct APIs {
        static let baseURL = "https://pokeapi.co/"
        static let coversURL = "https://covers.openlibrary.org/"
    }
    
    static var pokemonAPI: String {
        return APIs.baseURL + "api/v2/pokemon/"
    }
}
