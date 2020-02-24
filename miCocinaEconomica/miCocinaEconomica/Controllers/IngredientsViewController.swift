//
//  IngredientsViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import SDWebImage

class IngredientsViewController: UIViewController{
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    @IBOutlet weak var newDishesCollectionView: UICollectionView!
    var FirebaseRecipe = FirebaseStorage()
    var paso : Bool = false
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBAction func unwindToMainIngredientsDish(_ unwindSegue: UIStoryboardSegue) {
        
        paso = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        performSegue(withIdentifier: "IngredientsSegue", sender: self)
        
        if paso == false{
   
        
        }else if paso == false{
            //imageCell.isHidden = true
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
           let recipesArray = RecipesArray()
           let productsNameArray = recipesArray.loadFromFile(nameOfPathComponent: "ArrozConFrijoles")
            let image_url = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/mi-cocina-economica-98008.appspot.com/o/ArrozFrijoles.jpg?alt=media&token=cb218766-62c3-4279-ac91-6a26dbc99341")
           imageCell.sd_setImage(with: image_url as URL?)
           
           imageCell.isUserInteractionEnabled = true
           let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (self.sendToDishTableView(sender:)))
           tapGestureRecognizer.numberOfTouchesRequired = 1
           
           imageCell.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    override func viewDidLoad() {
    }
    
    @objc func sendToDishTableView(sender:UITapGestureRecognizer){
         performSegue(withIdentifier: "RecipeForIngredientsSegue", sender: self)
     }
    
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

//extension IngredientsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addedIngredientsCell", for: indexPath as IndexPath)
//
//
//            FirebaseRecipe.getRecipesJSON(forDish: "ArrozConFrijoles") { (Recipe) in
//                 let image_url = NSURL(string: Recipe.foto_url)
//                 let nombre = Recipe.titulo
//
//                 let recipesArray = RecipesArray()
//                 recipesArray.savetoFile(nameOfPathComponent: "ArrozConFrijoles", objectToEncode: Recipe)
//
//            }
//
//        let recipesArray = RecipesArray()
//        let productsNameArray = recipesArray.loadFromFile(nameOfPathComponent: "ArrozConFrijoles")
//        //let foto = productsNameArray[indexPath.row].foto_url
//        let image_url = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/mi-cocina-economica-98008.appspot.com/o/ArrozFrijoles.jpg?alt=media&token=cb218766-62c3-4279-ac91-6a26dbc99341")
//        //self.dayMenuImage.sd_setImage(with: image_url as URL?)
//        //imageViewCell.image =
//
//        //labelCell.text = productsNameArray[indexPath.item].titulo
//        let imageview : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
//
//        imageview.sd_setImage(with: image_url as URL?)
//
//              //imageview.image = UIImage(named:dulces_[indexPath.item].dulces)
//
//        cell.contentView.addSubview(imageview)
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
//
//        //cell.contentView.addSubview(imageview)
//
//        return cell
//    }
//
//
//
//}
