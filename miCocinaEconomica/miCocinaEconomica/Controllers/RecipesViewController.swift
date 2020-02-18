//
//  RecipesViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         if let controller = segue.destination as? RecipesTableViewController {
           if segue.identifier == "RecipesSegue" {
            slideInTransitioningDelegate.direction = .right
           }
           //controller.delegate = self
           slideInTransitioningDelegate.disableCompactHeight = false
           controller.transitioningDelegate = slideInTransitioningDelegate
           controller.modalPresentationStyle = .custom
         }
         
     }
    
    
}
