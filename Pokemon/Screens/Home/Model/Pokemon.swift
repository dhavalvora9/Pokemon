//
//  Pokemon.swift
//  Pokemon
//
//  Created by Vivek Virani on 26/06/22.
//

import Foundation

// MARK: - Pokemon

struct Pokemon: Codable {
    let count: Int
    let next, previous: String?
    let results: [Result]
}

// MARK: - Result

struct Result: Codable {
    let name: String
    let url: String
}
