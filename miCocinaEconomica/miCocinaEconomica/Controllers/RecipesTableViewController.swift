//
//  RecipesTableViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
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

            if let passingRecipe = presentedViewController as? CalendarViewController {
                passingRecipe.recipeFromTable_ = savedRecipeToArray[indexPath.row]
            }
            
            if let p = presentingViewController as? CalendarViewController {
                p.passedRecipe.append(passRecipe)
            }
            
            let pasandoRecipe = CalendarViewController()
            pasandoRecipe.data.append(savedRecipeToArray[indexPath.row].titulo)
            
            print(passRecipe)
            //dismiss(animated: true, completion: nil)
        }
    
}
