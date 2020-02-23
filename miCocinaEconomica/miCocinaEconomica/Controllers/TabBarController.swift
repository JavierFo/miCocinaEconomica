//
//  ViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/15/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    @IBInspectable var defaultIndex: Int = 0
    var JSONList = MxMarketsAPISession()
    var FirebaseRecipe = FirebaseStorage()
    var namE : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
                
//        FirebaseRecipe.getNameForJSONRecipe { (name)  in
//
//        }
        
//        FirebaseRecipe.getRecipesJSON(forDish: nameDish)  { (Recipe) in
//            //print(Recipe)
//            //print(Recipe.foto_url)
//        }
    }
    

}

