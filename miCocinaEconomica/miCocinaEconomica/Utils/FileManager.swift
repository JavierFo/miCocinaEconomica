//
//  FileManager.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/23/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import Foundation

    
    func savetoFile(nameOfPathComponent path : String, objectToEncode object: Recipe){
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let recipeToEncode = try? propertyListEncoder.encode(object)
        
        try? recipeToEncode?.write(to: recipesURL, options: .noFileProtection)
    }

    func loadFromFile(nameOfPathComponent path : String) -> Recipe{
        
        var decodedRecipe_ : Recipe?
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedRecipe = try? Data(contentsOf: recipesURL), let decodedRecipe = try? propertyListDecoder.decode(Recipe.self, from: retrievedRecipe){
            decodedRecipe_ = decodedRecipe
        }
        
        let decodedRecipeFinal = decodedRecipe_ ?? Recipe.init(foto_url: "-", ingredientes: ["-"], porciones: 0, preparacion: "-", titulo: "-")
        
        return decodedRecipeFinal
    }
    

