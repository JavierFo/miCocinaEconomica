//
//  RecipesTableViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

protocol selectedRecipesFromModalTableView{
    func sendDataToCalendarViewController(recipe: Recipe)
}

class RecipesTableViewController: UITableViewController {
    
    var recipeDelegate: selectedRecipesFromModalTableView? = nil
    let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
    var passRecipe : Recipe = Recipe(foto_url: "", ingredientes: [""], porciones: 0, preparacion: "", titulo: "")
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return savedRecipeToArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeToCalendarTableCell", for: indexPath)
            cell.textLabel?.text = savedRecipeToArray[indexPath.row].titulo

            return cell
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            //let cell = tableView.cellForRow(at: indexPath)
            //performSegue(withIdentifier: "savedRecipeView", sender: cell)
            passRecipe = savedRecipeToArray[indexPath.row]
            
            if self.recipeDelegate != nil {
                let selectedRecipe = self.passRecipe
                self.recipeDelegate?.sendDataToCalendarViewController(recipe: selectedRecipe)
//                print(passRecipe)
//                print(selectedRecipe)
                dismiss(animated: true, completion: nil)
            }
        }
    
}
