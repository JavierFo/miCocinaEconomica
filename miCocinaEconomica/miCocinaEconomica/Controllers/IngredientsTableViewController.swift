//
//  IngredientsTableViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    
    var JSONList = MxMarketsAPISession()
    var checkmark : Bool = false
    var buttonCounter = [Int]()
    
    override func viewDidLoad() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          JSONList.getAllIngredientsList { (ingredientes) in
              var productsName : [String] = []
              for name in ingredientes {
                  productsName.append(name.name)
                  
              }
            let recipesArray = RecipesArray()
            recipesArray.savetoFileStringArray(nameOfPathComponent: "productsList", objectToEncode: productsName)
            
          }
            
        let recipesArray = RecipesArray()
        var productsNameArray = recipesArray.loadFromFileStringArray(nameOfPathComponent: "productsList")
        productsNameArray.append("Arroz")
        productsNameArray.append("Frijol")
        productsNameArray.append("Carne")
        productsNameArray.append("Pollo")
        productsNameArray.append("Mole")
        productsNameArray.append("Tortillas")
        
        return productsNameArray.count
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
        let recipesArray = RecipesArray()
        var productsNameArray = recipesArray.loadFromFileStringArray(nameOfPathComponent: "productsList")
        productsNameArray.append("Arroz")
        productsNameArray.append("Frijol")
        productsNameArray.append("Carne")
        productsNameArray.append("Pollo")
        productsNameArray.append("Mole")
        productsNameArray.append("Tortillas")
        
        if buttonCounter.contains(indexPath.row){
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.textLabel?.text = productsNameArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        //let recipesArray = RecipesArray()
        //var productsNameArray = recipesArray.loadFromFileStringArray(nameOfPathComponent: "productsList")
        
        if cell?.textLabel?.text == "Aguacate Hass" {
            
        }
        
        
        if buttonCounter.contains(indexPath.row){
            let index = buttonCounter.firstIndex(of: indexPath.row)
            buttonCounter.remove(at: index!)
            tableView.reloadRows(at: [indexPath], with: .left)
        }
        else{
            buttonCounter.append(indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .right)
        }
        print(buttonCounter)
  
    }

    
}
