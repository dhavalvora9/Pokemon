//
//  PokemonDetailCellViewModel.swift
//  Pokemon
//
//  Created by Vivek Virani on 01/07/22.
//

import Foundation

struct PokemonDetailCellViewModel: Codable {
    let weight, height: String
    let name: String
    let imagePath: String
    let pokemonType: [String]
}
