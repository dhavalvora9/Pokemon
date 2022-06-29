//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Vivek Virani on 27/06/22.
//

import Foundation

class PokemonViewModel: NSObject {
    private var pokemonService: PokemonServiceProtocol
    
    private var cellViewModel = [PokemonCellViewModel]()
    
    var reloadTableView: (() -> Void)?
    
    private var results = [Result]()
    
    var alertTitle = "Something went wrong please try again later."
    var actionTitle = "OK"
    
    var pokemonCellViewModels = [PokemonCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }
    
    func getPokemons(for page: String?, completion: @escaping (_ error: String?) -> ()) {
        pokemonService.getPokemons(forPage: page) { success, pokemon, error in
            if success, let pokemon = pokemon {
                self.results = pokemon.results
                self.cellViewModel = [PokemonCellViewModel]()
                
                for result in pokemon.results {
                    self.cellViewModel.append(self.createCellModel(result: result))
                }

                self.pokemonCellViewModels = self.cellViewModel
                completion(error)
            } else {
                completion(error)
            }
        }
    }
    
    func createCellModel(result: Result) -> PokemonCellViewModel {
        let name: String = result.name.capitalized
        let url: String = result.url
        
        return PokemonCellViewModel(name: name, url: url)        
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> PokemonCellViewModel {
        return pokemonCellViewModels[indexPath.row]
    }
}
