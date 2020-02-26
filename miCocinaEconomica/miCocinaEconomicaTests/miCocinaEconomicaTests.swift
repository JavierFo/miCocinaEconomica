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
    
    var sut: URLSession!
    
    override func setUp() {
      super.setUp()
      sut = URLSession(configuration: .default)
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }
    
    func testValidCallToMxMarketsGetsHTTPStatusCode200() {
      
      let url =
        URL(string: "https://mxmarkets.herokuapp.com/api/v1/products/")
      
      let promise = expectation(description: "Status code: 200")

    
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
        
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
    
      wait(for: [promise], timeout: 5)
    }
    
    func testCallToToMxMarketsCompletes() {
          let url =
            URL(string: "https://mxmarkets.herokuapp.com/api/v1/products/")
          let promise = expectation(description: "Completion handler invoked")
          var statusCode: Int?
          var responseError: Error?

          let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
          }
          dataTask.resume()
          wait(for: [promise], timeout: 5)

          XCTAssertNil(responseError)
          XCTAssertEqual(statusCode, 200)
    }
    
}

