//
//  File.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/22/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import Foundation

struct Recipe : Codable {
    var foto_url : String
    var ingredientes : [String]
    var porciones : Int
    var preparacion : String
    var titulo : String
    
        init(foto_url: String, ingredientes: [String], porciones : Int, preparacion : String, titulo : String){
            self.titulo = titulo
            self.ingredientes = ingredientes
            self.porciones = porciones
            self.preparacion = preparacion
            self.foto_url = foto_url
    }
}
