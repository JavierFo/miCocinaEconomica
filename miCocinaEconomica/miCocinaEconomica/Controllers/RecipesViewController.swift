//
//  RecipesViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {
    
    @IBOutlet weak var editTablesbTN: UIButton!
        
    var savedRecipeToArray = loadFromAppendedArrayofRecipes(nameOfPathComponent: "savedArrayofRecipes")
    
    @IBAction func unwindToCalendarRecipes(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindToCalendarRecipes2(_ unwindSegue: UIStoryboardSegue) {
    }
    
    var pressedRecipee_ : Recipe?
    
    override func viewDidLoad() {
        view.accessibilityIdentifier = "ThirdView"

    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func editTablesButton(_ sender: UIButton) {
        
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
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
        return savedRecipeToArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableCell", for: indexPath)
        cell.textLabel?.text = savedRecipeToArray[indexPath.row].titulo
        cell.showsReorderControl = true

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) 
        pressedRecipee_ = savedRecipeToArray[indexPath.row]
        performSegue(withIdentifier: "savedRecipeView", sender: cell)

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            savedRecipeToArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}

