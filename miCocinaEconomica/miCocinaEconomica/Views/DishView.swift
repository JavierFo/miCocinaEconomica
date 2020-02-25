//
//  DishView.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/23/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class DishView: UIView{
    
    @IBOutlet weak var dishViewContainer: UIView!
    @IBOutlet weak var dishTitleLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var dishPortionsLabel: UILabel!
    @IBOutlet weak var dishPhotoImageView: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var preparationTextView: UITextView!
    
    //    Constructores
    override init(frame: CGRect) {
        super.init(frame: frame)
        dish()
    }
    
    // Constructor falible, puede cargar como no puede cargar
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dish()
    }
    
    private func dish(){
        //          Hace un auto cargado
        Bundle.main.loadNibNamed("DishView", owner: self, options: nil)
        //          Cuando el componente se cargue en memoria, se pone en la vista que lo mando a llamar
        addSubview(dishViewContainer)
        //        Tamaño dependendiendo de donde aparezca
        dishViewContainer.frame = self.bounds
        //          Para ajustarse dependiendo del tamaño que queremos
        dishViewContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
