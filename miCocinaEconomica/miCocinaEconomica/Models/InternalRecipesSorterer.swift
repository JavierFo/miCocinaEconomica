//
//  InternalRecipesSorterer.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/24/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

enum RecipesInDatabase {
    case ArrozConFrijoles
    case Flautas
    case EnchiladasMole
    case EnsaladaLechuga
    case EnsaladaAguacate
    case Alitas
    case Ninguno
}

class InternalRecipesSorterer {
    var JSONList = MxMarketsAPISession()
    var  ingredientsSort : RecipesInDatabase = .Ninguno
    func ingredientsSorterer(){
        
        JSONList.getAllIngredientsList { (ingredientes) in
         var productsName : [String] = []
         for name in ingredientes {
             productsName.append(name.name)
             
         }
           let recipesArray = RecipesArray()
           recipesArray.savetoFileStringArray(nameOfPathComponent: "productsList", objectToEncode: productsName)
           
         }
       
        //let recipesArray = RecipesArray()
        //var productsNameArray = recipesArray.loadFromFileStringArray(nameOfPathComponent: "productsList")
        
        switch ingredientsSort {
            
                case .Alitas: break
                        
                case .ArrozConFrijoles: break
                    
                case .Flautas: break
                    
                case .EnchiladasMole: break
                    
                case .EnsaladaLechuga: break
                    
                case .EnsaladaAguacate: break
            
                case .Ninguno: break
        }
    }
    
}


