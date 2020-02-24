//
//  RecipesTableViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    override func viewWillAppear(_ animated: Bool) {
        let rcpes = RecipesArray()
        let rcpesArray = rcpes.loadFromFile(nameOfPathComponent: "RecetaDelDia")
        print(rcpesArray)
    }
}
