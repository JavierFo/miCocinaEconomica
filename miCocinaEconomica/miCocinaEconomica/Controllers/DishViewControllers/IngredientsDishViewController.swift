//
//  IngredientsDishViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/23/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class IngredientsDishViewController: UIViewController{
    var FirebaseRecipe = FirebaseStorage()

    @IBOutlet weak var dishView: DishView!
               
       override func viewDidLoad() {
           
           //saveRecipe.isEnabled = true
           var listaIngredientesFinal : String = ""
          
               self.FirebaseRecipe.getRecipesJSON(forDish: "ArrozConFrijoles") { (Recipe) in
                   
                   self.dishView.dishTitleLabel.adjustsFontSizeToFitWidth = true
                   self.dishView.dishTitleLabel.minimumScaleFactor = 0.2
                   self.dishView.dishTitleLabel.numberOfLines = 2
                   
                   let image_url = NSURL(string: Recipe.foto_url)
                   self.dishView.dishPhotoImageView.sd_setImage(with: image_url as URL?)
                   self.dishView.dishPortionsLabel.text = "Porciones: " + String(Recipe.porciones)
                   self.dishView.dishTitleLabel.text = Recipe.titulo
                   self.dishView.preparationTextView.text = Recipe.preparacion + "."
                   
                   for ingredient in Recipe.ingredientes {
                       listaIngredientesFinal.append(ingredient + ". ")
                   }
                   self.dishView.ingredientsTextView.text = listaIngredientesFinal
               }
           dishView.dishPriceLabel.text = "Precio: $"
       }
    
}
