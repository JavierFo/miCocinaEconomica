//
//  IngredientsList.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/22/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

struct IngredientsList: Codable {
    var id : Int
    var slug : String
    var name : String
    var quality: Int
    var category: String
    var kind: String
    var image_url: String?
}
