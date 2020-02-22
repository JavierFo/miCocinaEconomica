//
//  IngredientDetails.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/22/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

struct IngredientDetails : Codable{
    var id : Int
    var slug : String
    var name : String
    var quality : Int
    var category : String
    var kind : String
    var image_url : String?
    var current_price : CurrentPrice
    var predicted_price : PredictedPrice
    var average_prices : [AveragePrices]
}

struct CurrentPrice : Codable{
    var product_id : Int
    var variant: Variant
    var cost_cents : Int
    var cost_unit_cents : Int
    var currency : String
    var published_at : String
    var created_at : String
    var updated_at : String
}

struct Variant : Codable{
    var name : String
    var quantity : Int
    var unit : String
}

struct PredictedPrice : Codable{
    var unit : String
    var currency : String
    var cost_unit_cents : Int
    var prediction_date : String
}

struct AveragePrices : Codable{
    var product_id : Int
    var unit : String
    var cost_cents : Int
    var currency : String
    var year : Int
    var week : Int
    var published_at : String
    var created_at : String
    var updated_at : String
}
