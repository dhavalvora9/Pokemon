//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Vivek Virani on 27/06/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: PokemonCellViewModel? {
        didSet {
            initView()
        }
    }
    
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
        self.titleLabel.text = cellViewModel?.name
    }
}
