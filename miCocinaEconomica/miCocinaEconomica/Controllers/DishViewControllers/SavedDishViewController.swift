//
//  SavedDishViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/23/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class SavedDishViewController: UIViewController{
    
    var recipe_ : Recipe?
    @IBOutlet weak var dishView: DishView!
    var FirebaseRecipe = FirebaseStorage()
    var pressedName : String?
    
    override func viewDidLoad() {
        var listaIngredientesFinal : String = ""

               dishView.dishTitleLabel.adjustsFontSizeToFitWidth = true
               dishView.dishTitleLabel.minimumScaleFactor = 0.2
               dishView.dishTitleLabel.numberOfLines = 2

               let image_url = NSURL(string: recipe_?.foto_url ?? "")
               dishView.dishPhotoImageView.sd_setImage(with: image_url as URL?)
               //dishView.dishPortionsLabel.text = "Porciones: " + String(recipe_?.porciones)
               dishView.dishTitleLabel.text = recipe_?.titulo
               self.dishView.preparationTextView.text = (recipe_?.preparacion ?? "") + "."

               for ingredient in recipe_?.ingredientes ?? [] {
                   listaIngredientesFinal.append(ingredient + ". ")
               }
               self.dishView.ingredientsTextView.text = listaIngredientesFinal

               dishView.dishPriceLabel.text = "Precio: $"
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}
