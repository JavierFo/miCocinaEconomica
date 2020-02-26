//
//  RecipesTableViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
            return savedRecipeToArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeToCalendarTableCell", for: indexPath)
            let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
            cell.textLabel?.text = savedRecipeToArray[indexPath.row].titulo

            return cell
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            //let cell = tableView.cellForRow(at: indexPath)
            //let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
            //pressedRecipee_ = savedRecipeToArray[indexPath.row]
            //performSegue(withIdentifier: "savedRecipeView", sender: cell)

        }
        
    
}
