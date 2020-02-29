//
//  File.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/22/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import Foundation

var generalArray : [Recipe] = []

struct Recipe : Codable {
    var foto_url : String = ""
    var ingredientes : [String] = [""]
    var porciones : Int = 0
    var preparacion : String = ""
    var titulo : String = ""
    
}
