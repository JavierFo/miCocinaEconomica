//
//  IngredientsViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController{
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? IngredientsTableViewController {
          if segue.identifier == "IngredientsSegue" {
            slideInTransitioningDelegate.direction = .left
          }
          //controller.delegate = self
          slideInTransitioningDelegate.disableCompactHeight = false
          controller.transitioningDelegate = slideInTransitioningDelegate
          controller.modalPresentationStyle = .custom
        }
        
    }
    
    
}
