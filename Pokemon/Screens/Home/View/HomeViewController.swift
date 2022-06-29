//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Vivek Virani on 26/06/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    lazy var viewModel = {
        PokemonViewModel()
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initView()
        getPokemons(isForNextPage: false)
    }
    
    // MARK: - Initialization
    
    func initView() {
        // TableView customization
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        pokemonTableView.tableFooterView = UIView()
        pokemonTableView.allowsSelection = false
        pokemonTableView.keyboardDismissMode = .onDrag
        
        // Register cell
        pokemonTableView.register(PokemonTableViewCell.nib, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - UI
    
    func setupUI() {
        searchView.layer.cornerRadius = 10
        searchView.clipsToBounds = true
    }

    // MARK: API Calling
    
    func getPokemons(isForNextPage: Bool) {
        // Fetch data using webservice
        viewModel.getPokemons(isForNextPage: isForNextPage) { [weak self] error in
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
                self?.pokemonTableView.reloadData()
            }
        }
    }
    
    // MARK: - IBAction
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let searchText = textField.text {
            
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.pokemonCellViewModels.count {
            print("End ")
            self.getPokemons(isForNextPage: true)
//            viewModel.addAddtionalData()

//            // Reload TableView closure
//            viewModel.reloadTableView = { [weak self] in
//                DispatchQueue.main.async {
//                    self?.searchIndicator.stopAnimating()
//                    self?.searchButton.isHidden = false
//                    self?.booksTableView.reloadData()
//                }
//            }
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonCell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else {
            fatalError("xib does not exists")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        pokemonCell.cellViewModel = cellVM
        return pokemonCell
    }
}
