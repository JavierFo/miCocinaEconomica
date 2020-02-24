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
    
    override func viewDidLoad() {
         let recipes_Array = RecipesArray()
        print(recipes_Array.recipesArray)
        //recipesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //recipesTableView.reloadData()
    }
   
    let data: [String] = ["4","5","4","5"]

}

extension RecipesViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          let rcpes = RecipesArray()
          let rcpesArray = rcpes.loadFromFile(nameOfPathComponent: "RecetaDelDia")
          //print(rcpesArray)
        return rcpesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTableCell", for: indexPath)
        //let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "recipeTableCell")
        //let cell = self.recipesTableView.dequeueReusableCell(withIdentifier: "recipeTableCell", for: indexPath) as UITableViewCell

        let rcpes = RecipesArray()
        let rcpesArray = rcpes.loadFromFile(nameOfPathComponent: "RecetaDelDia")
        //print(rcpesArray)
        cell.textLabel?.text = rcpesArray[indexPath.row].titulo
            //recipes_Array.recipesArray[indexPath.row].titulo
        
        return cell
    }
    
    
    
}

