//
//  IngredientsTableViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

protocol IngredientsPassed: class {
    func didRecieveDataUpdate(data: [Int])
}

class IngredientsTableViewController: UITableViewController {
    
    var JSONList = MxMarketsAPISession()
    var checkmark : Bool = false
    var buttonCounter = [Int]()
    weak var delegate: IngredientsPassed?
    
    override func viewDidLoad() {
        tableView.reloadData()
    }
    
    @IBAction func dishSearchButton(_ sender: UIButton) {
        
        delegate?.didRecieveDataUpdate(data: buttonCounter)
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
        let productsNameArray = recipesArray.loadFromFileStringArray(nameOfPathComponent: "productsList")
        
        return productsNameArray.count
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
        let recipesArray = RecipesArray()
        let productsNameArray = recipesArray.loadFromFileStringArray(nameOfPathComponent: "productsList")
        
        if buttonCounter.contains(indexPath.row){
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.textLabel?.text = productsNameArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let cell = tableView.cellForRow(at: indexPath)
        
        if buttonCounter.contains(indexPath.row){
            let index = buttonCounter.firstIndex(of: indexPath.row)
            buttonCounter.remove(at: index!)
            tableView.reloadRows(at: [indexPath], with: .left)
        }
        else{
            buttonCounter.append(indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .right)
        }
  
    }

    
}
