//
//  miCocinaEconomicaUITests.swift
//  miCocinaEconomicaUITests
//
//  Created by Javier Ferrer on 2/15/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import XCTest
@testable import miCocinaEconomica

class miCocinaEconomicaUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOfMainFlow() {

        let app = XCUIApplication()
        app.launch()
        
        let isDisplayingOnboarding = app.otherElements["FirstView"]
        let recipeDayImageView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .image).element
        
        XCTAssertTrue(recipeDayImageView.exists)
        XCTAssertTrue(isDisplayingOnboarding.exists)
        
        if recipeDayImageView.isSelected{
            let isDisplayDishViewController = app.otherElements["SecondView"]
            XCTAssertTrue(isDisplayDishViewController.exists)
            XCTAssertTrue(recipeDayImageView.exists)
            XCTAssertTrue(isDisplayingOnboarding.exists)
            
            XCTAssertFalse(recipeDayImageView.exists)
            XCTAssertFalse(isDisplayingOnboarding.exists)
        }
        
        let navigationBarsQuery = app.navigationBars
        
        if recipeDayImageView.isSelected{
            
            let saveButton = navigationBarsQuery.buttons["Guardar Receta"]
            XCTAssertTrue(saveButton.exists)
            let saveAlert = app.alerts["Felicidades"].scrollViews.otherElements.buttons["OK"]
            XCTAssertFalse(saveAlert.exists)
        }
        
        let recipesViewController = app.otherElements["ThirdView"]
        let tablesQuery = app.tables

        let tabBarsQuery = app.tabBars
        if tabBarsQuery.buttons["Mis Recetas"].isSelected {
            XCTAssertTrue(recipesViewController.exists)
            XCTAssertNotNil(tablesQuery.children(matching: .cell).element(boundBy: 0))
        }
                
        tabBarsQuery.buttons["Menú Del Día"].tap()
        let elementLottie = app.otherElements["FirstView"].children(matching: .other).element(boundBy: 1)
        if  tabBarsQuery.buttons["Menú Del Día"].isSelected{
            XCTAssertTrue(recipeDayImageView.exists)
            XCTAssertTrue(isDisplayingOnboarding.exists)
            XCTAssertTrue(elementLottie.exists)
        }
        
        if tabBarsQuery.buttons["Mi Despensa"].isSelected{
            let navButton = navigationBarsQuery.buttons["Seleccionar Ingredientes"]
            XCTAssertTrue(navButton.isEnabled)
        }
        
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                        XCUIApplication().launch()
            }
        }
    }
}
