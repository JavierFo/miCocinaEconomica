//
//  FirebaseStorage.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/21/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class FirebaseStorage {
    
    var ref: DatabaseReference!
    var nameref: DatabaseReference!
    var  title_ : String = ""
    var  preparacion_ : String = ""
    var  porciones_ : Int = 0
    var  ingredientes_ : [String] = [""]
    var  foto_url_ : String = ""
    
    func getNameForJSONRecipe(completion: @escaping ((_ recipeName : String) -> ())) {
        nameref = Database.database().reference()
        nameref.child("MenuDelDia").observe(.value) { (DataSnapshot) in
            let MenuOfTheDayName = DataSnapshot.value as? String
            if let dayMenuName = MenuOfTheDayName{
                completion(dayMenuName)
            }
        }
    }
    
    func getRecipesJSON(forDish dish: String, completion: @escaping ((_ recipe : Recipe) -> ())) {
        
        ref = Database.database().reference()
        
        ref.child(dish).observe(.value, with: { (DataSnapshot) in

            let recipeElements = DataSnapshot.value as? NSDictionary
            
            guard let title = recipeElements?["titulo"] as? String, let preparacion = recipeElements?["preparacion"] as? String, let  porciones = recipeElements?["porciones"] as? Int, let ingredientes = recipeElements?["ingredientes"] as? [String], let foto_url = recipeElements?["foto_url"] as? String else { return }
                
            self.title_ = title
            self.preparacion_ = preparacion
            self.porciones_ = porciones
            self.ingredientes_ = ingredientes
            self.foto_url_ = foto_url

            let completeRecipe = Recipe(foto_url: self.foto_url_, ingredientes: self.ingredientes_, porciones: self.porciones_, preparacion: self.preparacion_, titulo: self.title_)
            completion(completeRecipe)
            
            
        })
    }
    
    
}
