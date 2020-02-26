//
//  MainMenuViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import Lottie
import FirebaseStorage
import SDWebImage

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var animationArea: UIView!
    @IBOutlet weak var dayMenuImage: UIImageView!
    @IBOutlet weak var menusCollectionView: UICollectionView!
    
    let animationView = AnimationView(name: "2605-cooking")
    var FirebaseRecipe = FirebaseStorage()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
     override func viewDidLoad() {
            super.viewDidLoad()
        view.accessibilityIdentifier = "FirstView"
        dayMenuImage.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (self.sendToMenusTableView(sender:)))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        dayMenuImage.addGestureRecognizer(tapGestureRecognizer)
                    
        FirebaseRecipe.getNameForJSONRecipe { (nameDish) in
            self.FirebaseRecipe.getRecipesJSON(forDish: nameDish) { (Recipe) in
                let image_url = NSURL(string: Recipe.foto_url)
                self.dayMenuImage.sd_setImage(with: image_url as URL?)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animationView.frame = animationArea.frame
        animationView.center = animationArea.center
        animationView.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()
    }
    
    @objc func sendToMenusTableView(sender:UITapGestureRecognizer){
        performSegue(withIdentifier: "DayMenu", sender: self)
    }
    
    @IBAction func unwindToMainMenu(_ unwindSegue: UIStoryboardSegue) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
          if segue.identifier == "DayMenu" {
           
          }
    }
    
}
 
extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMenus", for: indexPath as IndexPath)
         
        cell.backgroundColor = UIColor.gray
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
         
        return cell
    }
    
}
