//
//  RecipesViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {
    
    @IBAction func unwindToCalendarRecipes(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindToCalendarRecipes2(_ unwindSegue: UIStoryboardSegue) {
    }
    
    var pressedRecipe : String = ""
    var pressedRecipee_ : Recipe?
    var generalArray_ : [Recipe] = []
    
    override func viewDidLoad() {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savedRecipeView"{ 
            let pressedRecipe_ = segue.destination as! SavedDishViewController
            pressedRecipe_.recipe_ = pressedRecipee_
        }
    }
}

extension RecipesViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
        return savedRecipeToArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableCell", for: indexPath)
        let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
        cell.textLabel?.text = savedRecipeToArray[indexPath.row].titulo

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) 
        let savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
        pressedRecipee_ = savedRecipeToArray[indexPath.row]
        performSegue(withIdentifier: "savedRecipeView", sender: cell)

    }
    
}

