//
//  PokemonDetailCell.swift
//  Pokemon
//
//  Created by Vivek Virani on 01/07/22.
//

import UIKit

class PokemonDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: PokemonDetailCellViewModel? {
        didSet {
            initView()
        }
    }
    
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    
    func initView() {
        if let cellViewModel = cellViewModel {
            switch index {
            case 1:
                self.titleLabel.text = "Name: "
                self.detailLabel.text = cellViewModel.name
                
            case 2:
                self.titleLabel.text = "Weight: "
                self.detailLabel.text = cellViewModel.weight + "kg"
                
            case 3:
                self.titleLabel.text = "Height: "
                self.detailLabel.text = cellViewModel.height + "'"
                
            case 4:
                self.titleLabel.text = "Type: "
                self.detailLabel.text = cellViewModel.pokemonType.joined(separator: ", ").capitalized
                
            default: break
            }
        }
    }
}
