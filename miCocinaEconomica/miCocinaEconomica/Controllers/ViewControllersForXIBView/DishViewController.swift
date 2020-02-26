//
//  DishViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/23/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

protocol DataModelDelegate: class {
    func didRecieveDataUpdate(data: [Recipe])
}

class DishViewController: UIViewController {

    var recipe_ : Recipe?
    @IBOutlet weak var dishView: DishView!
    @IBOutlet weak var saveRecipe: UIBarButtonItem!
    
    var FirebaseRecipe = FirebaseStorage()
    weak var delegate: DataModelDelegate?
    
    override func viewDidLoad() {
        view.accessibilityIdentifier = "SecondView"
        saveRecipe.isEnabled = true
        var listaIngredientesFinal : String = ""
        FirebaseRecipe.getNameForJSONRecipe { (nameDish) in
            self.FirebaseRecipe.getRecipesJSON(forDish: nameDish) { (Recipe) in
                
                saveRecipeToFile(nameOfPathComponent: "RecipeArrayBridge", objectToEncode: Recipe)

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
        
        //dishView.dishPriceLabel.text = "Precio: $"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let recipes_Array = RecipesArray()
        //let loadedRecipe = loadFromFile(nameOfPathComponent: "RecetaDelDia")
        let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")

        for recipeA in recipes_Array.recipesArray {
            for recipeB in savedRecipeToArray {
                if recipeA.titulo == recipeB.titulo {
                    saveRecipe.isEnabled = false
                }
            }
        }
        
    }
    
    @IBAction func saveRecipe(_ sender: UIBarButtonItem) {
        
        let savedRecipeToArray = loadRecipeFromFile(nameOfPathComponent: "RecipeArrayBridge")
        showAlert(withTitleAndMessage: "Felicidades", message: "Receta Guardada")
        appendRecipesIntoArray(withRecipe: savedRecipeToArray)
        //print(savedRecipeToArray)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
        print(savedRecipeToArray)
        
    }
    
    func showAlert(withTitleAndMessage title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

