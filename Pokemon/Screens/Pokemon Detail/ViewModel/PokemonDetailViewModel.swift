//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Vivek Virani on 01/07/22.
//

import Foundation

class PokemonDetailViewModel: NSObject {
    private var pokemonDetailService: PokemonDetailServiceProtocol
    
    private var cellViewModel = [PokemonDetailCellViewModel]()
    
    var reloadTableView: (() -> Void)?
    
    var alertTitle = "Something went wrong please try again later."
    var actionTitle = "OK"
    
    var pokemonCellViewModel: PokemonDetailCellViewModel? {
        didSet {
            reloadTableView?()
        }
    }
    
    init(pokemonDetailService: PokemonDetailServiceProtocol = PokemonDetailService()) {
        self.pokemonDetailService = pokemonDetailService
    }
    
    func getPokemonDetail(from path: String?, completion: @escaping (_ error: String?) -> ()) {
        pokemonDetailService.getPokemonDetail(from: path) { success, results, error in
            if success, let results = results {
                self.pokemonCellViewModel = self.createCellModel(pokemonDetail: results)
                completion(error)
            } else {
                completion(error)
            }
        }
    }
    
    func createCellModel(pokemonDetail: PokemonDetail) -> PokemonDetailCellViewModel {
        let name: String = pokemonDetail.name.capitalized
        let weight: String = String(pokemonDetail.weight)
        let height: String = String(pokemonDetail.height)
        let imagePath: String = pokemonDetail.sprites.other.home.frontDefault
        let pokemonType: [String] = pokemonDetail.types.map({$0.type.name})
        
        return PokemonDetailCellViewModel(weight: weight, height: height, name: name, imagePath: imagePath, pokemonType: pokemonType)
    }
}

