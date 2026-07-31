//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var viewRound: UIView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    // MARK: - Funciones Inicio
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewRound.layer.cornerRadius = 10.0
        self.viewRound.layer.borderWidth = 1
        self.viewRound.layer.borderColor = UIColor.black.cgColor
        
        self.icon.layer.cornerRadius = self.icon.frame.size.width / 2
        self.icon.layer.borderWidth = 0.5
        self.icon.layer.borderColor = UIColor.systemGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
