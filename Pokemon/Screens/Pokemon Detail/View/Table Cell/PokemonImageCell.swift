//
//  PokemonImageCell.swift
//  Pokemon
//
//  Created by Vivek Virani on 30/06/22.
//

import UIKit
import SDWebImage

class PokemonImageCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: PokemonDetailCellViewModel? {
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
        // Pokemon image loading indicator & transition
        self.pokemonImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.pokemonImageView.sd_imageIndicator?.startAnimatingIndicator()
        self.pokemonImageView.sd_imageTransition = .fade
        
        self.pokemonImageView.sd_setImage(with: URL(string: cellViewModel?.imagePath ?? "placeholder"))
    }
}
