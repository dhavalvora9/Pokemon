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
    
    private var pokemon: Pokemon?
    
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
    
    func getPokemons(isForNextPage: Bool, completion: @escaping (_ error: String?) -> ()) {
        // Check if it's last page of API and don't request additional data
        if isForNextPage && self.pokemon?.next == nil {
            return
        }
        
        // Get next page url 
        let nextPage = isForNextPage ? self.pokemon?.next : nil
        pokemonService.getPokemons(for: nextPage) { success, pokemon, error in
            if success, let pokemon = pokemon {
                self.pokemon = pokemon
                
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
    
    func searchPokemon(byName: String) {
        let filteredData = self.cellViewModel.filter { $0.name.lowercased().contains(byName.lowercased()) }
        if filteredData.isEmpty && byName.count <= 0 {
            self.pokemonCellViewModels = self.cellViewModel
        } else {
            self.pokemonCellViewModels = filteredData
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
