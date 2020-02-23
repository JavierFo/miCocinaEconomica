//
//  miCocinaEconomicaTests.swift
//  miCocinaEconomicaTests
//
//  Created by Javier Ferrer on 2/15/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import XCTest
import Lottie
@testable import miCocinaEconomica
import FirebaseDatabase

class miCocinaEconomicaTests: XCTestCase {

    func testGetIngredientsListJSON() {
        let JSONList = MxMarketsAPISession()
        JSONList.getAllIngredientsList{ (IngredientsList) in
            XCTAssertNotNil(IngredientsList)
        }
    }

    func testValidateLottiesExistance() {
        let animationView = AnimationView(name: "2605-cooking")
        XCTAssertNotNil(animationView)
    }
    
    func testGetIngredientDetailJSON(){
        let JSONList = MxMarketsAPISession()
        for id in 0...300 {
            JSONList.getDetailedIngredientInfo(withID: id) { (IngredientDetails) in
                XCTAssertNotNil(IngredientDetails)
            }
        }
    }
    
    func testGetRecipesFromDatabase(){
        let ref = Database.database().reference()
        ref.child("ArrozConFrijoles").observe(.childAdded) { (DataSnapshot) in
                XCTAssertNotNil(DataSnapshot)
        }
    }
    
    func testGetJSONFromDatabase(){
        let FirebaseRecipe = FirebaseStorage()
        FirebaseRecipe.getRecipesJSON(forDish: "wololo") { _Recipe in
            let passedRecipe : Recipe = _Recipe
            XCTAssertThrowsError(passedRecipe)
        }
    }
    
    func testGetDishDayName() {
        let FirebaseRecipe = FirebaseStorage()
        FirebaseRecipe.getNameForJSONRecipe { (nameOfDish) in
            let _nameOfDish = nameOfDish
            XCTAssertNotNil(_nameOfDish)
        }
    }
    
    
}

