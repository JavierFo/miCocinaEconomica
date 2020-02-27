//
//  selectedDishCollectionViewCell.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/24/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class selectedDishCollectionViewCell: UICollectionViewCell {
    static let identifier : String = "selectedIngForDishes"
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
