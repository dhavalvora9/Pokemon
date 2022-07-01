//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by Vivek Virani on 28/06/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonCellModel: PokemonCellViewModel?
    
    lazy var viewModel = {
        PokemonDetailViewModel()
    }()
    
    @IBOutlet weak var pokemonDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.getPokemonDetail()
    }
    
    // MARK: - Initialization
    
    func initView() {
        // TableView customization
        pokemonDetailTableView.dataSource = self
        pokemonDetailTableView.delegate = self
        pokemonDetailTableView.tableFooterView = UIView()
        
        // Register cell
        pokemonDetailTableView.register(PokemonImageCell.nib, forCellReuseIdentifier: PokemonImageCell.identifier)
        pokemonDetailTableView.register(PokemonDetailCell.nib, forCellReuseIdentifier: PokemonDetailCell.identifier)
    }
    
    // MARK: API Calling
    
    func getPokemonDetail() {
        // Fetch data using webservice
        viewModel.getPokemonDetail(from: pokemonCellModel?.url) { [weak self] error in
            if let error = error {
                // Present alert controller
                let alert = UIAlertController(title: self?.viewModel.alertTitle, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: self?.viewModel.actionTitle, style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.pokemonDetailTableView.reloadData()
            }
        }
    }

}

// MARK: - UITableViewDataSource

extension PokemonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let pokemonImageCell = tableView.dequeueReusableCell(withIdentifier: PokemonImageCell.identifier, for: indexPath) as! PokemonImageCell
            pokemonImageCell.cellViewModel = viewModel.pokemonCellViewModel
            return pokemonImageCell
            
        default:
            let pokemonDetailCell = tableView.dequeueReusableCell(withIdentifier: PokemonDetailCell.identifier, for: indexPath) as! PokemonDetailCell
            pokemonDetailCell.index = indexPath.row
            pokemonDetailCell.cellViewModel = viewModel.pokemonCellViewModel
            
            return pokemonDetailCell
        }
    }
}

// MARK: - UITableViewDelegate

extension PokemonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        } else {
            return UITableView.automaticDimension
        }
    }
}
