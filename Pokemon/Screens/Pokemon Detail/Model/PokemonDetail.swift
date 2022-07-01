//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Vivek Virani on 30/06/22.
//

import Foundation

// MARK: - Pokemon Detail

struct PokemonDetail: Codable {
    let weight, height: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
}

// MARK: - Sprites

struct Sprites: Codable {
    let other: Other
}

// MARK: - Other

struct Other: Codable {
    let home: Home
}

// MARK: - Home

struct Home: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement

struct TypeElement: Codable {
    let type: PokemonType
}

// MARK: - TypeType

struct PokemonType: Codable {
    let name: String
}
