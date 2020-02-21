//
//  MainMenuViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/18/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import Lottie

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var animationArea: UIView!
    
    let animationView = AnimationView(name: "2605-cooking")

     override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
        }
    
    override func viewDidAppear(_ animated: Bool) {
        animationView.frame = animationArea.frame
        animationView.center = animationArea.center
        animationView.contentMode = .scaleAspectFill
        view.backgroundColor = .none
        view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()
    }
    
}
 
extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMenus", for: indexPath as IndexPath)
         
         cell.backgroundColor = UIColor.clear
         cell.layer.borderColor = UIColor.black.cgColor
         cell.layer.borderWidth = 1
         cell.layer.cornerRadius = 5
         
         return cell
    }
    
}
