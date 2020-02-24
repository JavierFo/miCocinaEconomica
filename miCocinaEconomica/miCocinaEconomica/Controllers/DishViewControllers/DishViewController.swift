//
//  DishViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/23/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class DishViewController: UIViewController {

    var recipe_ : Recipe?
    @IBOutlet weak var dishView: DishView!
    @IBOutlet weak var saveRecipe: UIBarButtonItem!
    
    var FirebaseRecipe = FirebaseStorage()
        
    override func viewDidLoad() {
        
        saveRecipe.isEnabled = true
        var listaIngredientesFinal : String = ""
        FirebaseRecipe.getNameForJSONRecipe { (nameDish) in
            self.FirebaseRecipe.getRecipesJSON(forDish: nameDish) { (Recipe) in
                
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
        }
        
        dishView.dishPriceLabel.text = "Precio: $"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let recipes_Array = RecipesArray()
        //let loadedRecipe = loadFromFile(nameOfPathComponent: "RecetaDelDia")
        let rcpes = RecipesArray()
        let rcpesArray = rcpes.loadFromFile(nameOfPathComponent: "RecetaDelDia")
        for recipeA in recipes_Array.recipesArray {
            for recipeB in rcpesArray {
                if recipeA.titulo == recipeB.titulo {
                    saveRecipe.isEnabled = false
                }
            }
        }
        
      
        
    }
    
    @IBAction func saveRecipe(_ sender: UIBarButtonItem) {
        
        FirebaseRecipe.getNameForJSONRecipe { (nameDish) in
        self.FirebaseRecipe.getRecipesJSON(forDish: nameDish) { (Recipe) in
                
                let rcpes = RecipesArray()
                rcpes.savetoFile(nameOfPathComponent: "RecetaDelDia", objectToEncode: Recipe)
                self.showAlert(withTitleAndMessage: "Felicidades!", message: "Receta Guardada En Su Dispositivo.")
                let recipes_Array = RecipesArray()
                recipes_Array.recipesArray.append(Recipe)
            }
        }
        
        saveRecipe.isEnabled = false
    }
    
    func showAlert(withTitleAndMessage title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

//extension DishViewController: DataModelDelegate{
//    func didRecieveDataUpdate(data: Recipe) {
//
//        DispatchQueue.main.async {
//            self.recipe_ = data
//            self.dishView.dishTitleLabel.text = self.recipe_?.titulo
//            self.dishView.dishPriceLabel.text = "?"
//
//            if let portions = self.recipe_?.porciones {
//                self.dishView.dishPortionsLabel.text = String(portions)
//             }
//            if let url = self.recipe_?.foto_url{
//                 let image_url = NSURL(string: url)
//                self.dishView.dishPhotoImageView.sd_setImage(with: image_url as URL?)
//             }
//
//             //dishView.ingredientsTextView.text = recipe_?.ingredientes
//            self.dishView.preparationTextView.text = self.recipe_?.preparacion
//        }
//
//    }
//}
