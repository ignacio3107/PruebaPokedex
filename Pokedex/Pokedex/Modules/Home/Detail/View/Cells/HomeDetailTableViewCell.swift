//
//  HomeDetailTableViewCell.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 31/07/26.
//

import UIKit

class HomeDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBorder.layer.cornerRadius = self.viewBorder.frame.height / 2
        self.viewBorder.layer.borderWidth = 1
        self.viewBorder.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
