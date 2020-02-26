//
//  IngredientsViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import SDWebImage
import Lottie

class IngredientsViewController: UIViewController{
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    var FirebaseRecipe = FirebaseStorage()
    @IBOutlet weak var selectedDishCollectionView: UICollectionView!
    let animationAvocadoView = AnimationView(name: "avocado")
    let animationLettuceView = AnimationView(name: "lettuce")
    @IBOutlet weak var avocadoView: UIView!
    @IBOutlet weak var selectIngredientsButton: UIBarButtonItem!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    var buttonCounterFromTable : [Int]?
    @IBAction func unwindToMainIngredientsDish(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        
        if let buttonCounterFromTable_ = buttonCounterFromTable {
            if buttonCounterFromTable_.isEmpty == true  {
                
                selectIngredientsButton.tintColor = .clear
                selectIngredientsButton.customView?.isHidden = true
                view.backgroundColor = .white
                selectedDishCollectionView.backgroundView?.backgroundColor = .white
                
                animationLettuceView.frame = avocadoView.frame
                animationLettuceView.center = avocadoView.center
                animationLettuceView.contentMode = .scaleAspectFit
                view.addSubview(animationLettuceView)
                animationLettuceView.loopMode = .loop
                animationLettuceView.play()
                
                messageLabel.text = "Oops! Parece que aun no encontramos una receta para ti..."
    
            }else if buttonCounterFromTable_.isEmpty == false{
                
                messageLabel.text = "Buscando Receta..."
                
            }
        }
        
        print(buttonCounterFromTable)
        
 
    }
    
    override func viewDidLoad() {
        
        selectIngredientsButton.tintColor = .clear
        selectIngredientsButton.customView?.isHidden = true
        view.backgroundColor = .white
        selectedDishCollectionView.backgroundView?.backgroundColor = .white
        
        animationAvocadoView.frame = avocadoView.frame
        animationAvocadoView.center = avocadoView.center
        animationAvocadoView.contentMode = .scaleAspectFit
        view.addSubview(animationAvocadoView)
        animationAvocadoView.loopMode = .loop
        animationAvocadoView.play()
        
        let nib = UINib(nibName: String(describing: selectedDishCollectionViewCell.self), bundle: nil)
        selectedDishCollectionView.register(nib, forCellWithReuseIdentifier: selectedDishCollectionViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? IngredientsTableViewController {
          if segue.identifier == "IngredientsSegue" {
            slideInTransitioningDelegate.direction = .left
          }
          slideInTransitioningDelegate.disableCompactHeight = false
          controller.transitioningDelegate = slideInTransitioningDelegate
          controller.modalPresentationStyle = .custom
        }
        
    }

}

extension IngredientsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectedDishCollectionViewCell.identifier, for: indexPath) as! selectedDishCollectionViewCell
        cell.isHidden = true
//        cell.labelCell.text = "self.view.frame.widthself.view.frame.width"
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
//        let image_url = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/mi-cocina-economica-98008.appspot.com/o/ArrozFrijoles.jpg?alt=media&token=cb218766-62c3-4279-ac91-6a26dbc99341")
//        cell.imageViewCell.sd_setImage(with: image_url as URL?)
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
}

extension IngredientsViewController: IngredientsPassed{
    
    func didRecieveDataUpdate(data: [Int]) {
        buttonCounterFromTable = data
    }
    
}
