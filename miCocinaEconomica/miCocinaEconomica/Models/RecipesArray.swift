//
//  RecipesArray.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/23/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import Foundation

class RecipesArray : Codable{
    
    var recipesArray : [Recipe] = []
    var generalArray : [Recipe] = []
    
    func savetoFile(nameOfPathComponent path : String, objectToEncode object: Recipe){
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        
        recipesArray.append(object)

            let recipeToEncode = try? propertyListEncoder.encode(recipesArray)
            try? recipeToEncode?.write(to: recipesURL, options: .noFileProtection)
    }

    func loadFromFile(nameOfPathComponent path : String) -> [Recipe]{
        
        var decodedRecipe_ : [Recipe]?
        var finalRecipeArray : [Recipe]?
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedRecipe = try? Data(contentsOf: recipesURL), let decodedRecipe = try? propertyListDecoder.decode([Recipe].self, from: retrievedRecipe){
            decodedRecipe_ = decodedRecipe
        }
        
        if let decodedRecipeFinal = decodedRecipe_ {
            finalRecipeArray = decodedRecipeFinal
        }

        return finalRecipeArray ?? []
        
    }
    
    func savetoFileStringArray(nameOfPathComponent path : String, objectToEncode object: [String]){
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        
            let recipeToEncode = try? propertyListEncoder.encode(object)
            try? recipeToEncode?.write(to: recipesURL, options: .noFileProtection)
    }
    
    func loadFromFileStringArray(nameOfPathComponent path : String) -> [String]{
        
        var decodedRecipe_ : [String]?
        var finalRecipeArray : [String]?
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedRecipe = try? Data(contentsOf: recipesURL), let decodedRecipe = try? propertyListDecoder.decode([String].self, from: retrievedRecipe){
            decodedRecipe_ = decodedRecipe
        }
        
        if let decodedRecipeFinal = decodedRecipe_ {
            finalRecipeArray = decodedRecipeFinal
        }

        return finalRecipeArray ?? []
        
    }
}


