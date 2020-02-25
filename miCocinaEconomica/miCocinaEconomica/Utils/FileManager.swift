//
//  FileManager.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/25/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import Foundation

func saveRecipeToFile(nameOfPathComponent path : String, objectToEncode object: Recipe){
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
    
    let propertyListEncoder = PropertyListEncoder()
    
        let recipeToEncode = try? propertyListEncoder.encode(object)
        try? recipeToEncode?.write(to: recipesURL, options: .noFileProtection)
}

func saveArrayOfRecipeToFile(nameOfPathComponent path : String, objectToEncode object: [Recipe]){
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
    
    let propertyListEncoder = PropertyListEncoder()
    
        let recipeToEncode = try? propertyListEncoder.encode(object)
        try? recipeToEncode?.write(to: recipesURL, options: .noFileProtection)
}

func loadRecipeFromFile(nameOfPathComponent path : String) -> Recipe{
    
    var decodedRecipe_ : Recipe?
    var finalRecipeArray : Recipe?
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let recipesURL = documentsDirectory.appendingPathComponent(path).appendingPathExtension("plist")
    
    let propertyListDecoder = PropertyListDecoder()
    if let retrievedRecipe = try? Data(contentsOf: recipesURL), let decodedRecipe = try? propertyListDecoder.decode(Recipe.self, from: retrievedRecipe){
        decodedRecipe_ = decodedRecipe
    }
    
    if let decodedRecipeFinal = decodedRecipe_ {
        finalRecipeArray = decodedRecipeFinal
    }
    
        return finalRecipeArray ?? Recipe(foto_url: "", ingredientes: [""], porciones: 0, preparacion: "", titulo: "")
}

func appendRecipesIntoArray(withRecipe recipe: Recipe){
        
    var savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
    
    if savedRecipeToArray.count == 0 {
    
        var generalArray_ = generalArray
        generalArray_.append(recipe)
        saveArrayOfRecipeToFile(nameOfPathComponent: "savedArrayofRecipes", objectToEncode: generalArray_)
        
    }else if savedRecipeToArray.count > 0 {
        
        savedRecipeToArray.append(recipe)
        saveArrayOfRecipeToFile(nameOfPathComponent: "savedArrayofRecipes", objectToEncode: savedRecipeToArray)
    }

}

func loadFromAppendedArrayofRecipes(nameOfPathComponent path : String) -> [Recipe]{
    
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
