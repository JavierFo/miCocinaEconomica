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
    
    
}

