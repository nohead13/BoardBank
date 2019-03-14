//
//  BoardBankUITests.swift
//  BoardBankUITests
//
//  Created by Artjoms Haleckis on 30/01/2019.
//  Copyright © 2019 Richard Neitzke. All rights reserved.
//

import XCTest

class BoardBankUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test01StartCleanNewGame() {
        //reset game to run test suit without problem
        let app = XCUIApplication()
        
        app.navigationBars["BoardBank"].children(matching: .button).element(boundBy: 0).tap()
        let newGameButtum =  app.tables/*@START_MENU_TOKEN@*/.staticTexts["New Game"]/*[[".cells.staticTexts[\"New Game\"]",".staticTexts[\"New Game\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(newGameButtum.exists)
        newGameButtum.tap()
        
        let alertsDialod = app.alerts["Are you sure?"]
        XCTAssertTrue(alertsDialod.exists)
        alertsDialod.buttons["New Game"].tap()
    }
    func test02CretePlayerOneWithCustomBalance() {
        let userNameOne = "UserName1"
        let userBalance = "1200"
        
        let app = XCUIApplication()
        app.navigationBars["BoardBank"].buttons["Add"].tap()
        
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.textFields["Player"].exists)
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Player"]/*[[".cells.staticTexts[\"Add Player\"]",".staticTexts[\"Add Player\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(tablesQuery.collectionViews.cells.otherElements.containing(.image, identifier:"cat").element.exists)
        
        tablesQuery.textFields["Player"].tap()
        
        //don't know how make typeText more beatiful
        let playerNameField = tablesQuery.textFields["Player"]
        playerNameField.typeText(userNameOne)
        
        //change 1500 to 1200
        let balanceField = app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"BALANCE")/*[[".cells.containing(.staticText, identifier:\"$\")",".cells.containing(.staticText, identifier:\"BALANCE\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).element
        balanceField.tap()
        
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ //In simulator should be activated "Keyboard -> Toggle Software Keyboard"
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        
        //input 1200
        balanceField.typeText(userBalance)
        
        //check balance text field
        let textField = tablesQuery.cells.containing(.textField, identifier:"1200").children(matching: .textField).element
        XCTAssertTrue(textField.exists)
        
        //select cat
        tablesQuery/*@START_MENU_TOKEN@*/.collectionViews/*[[".cells.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.cells.otherElements.containing(.image, identifier:"cat").element.tap()
        
        //add & save player
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Player"]/*[[".cells.staticTexts[\"Add Player\"]",".staticTexts[\"Add Player\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //check saved new playerOne
        XCTAssertTrue(app.collectionViews.staticTexts[userNameOne].exists)
        
        
    }
    func test03CretePlayerTwo() {
        let userNameTwo = "UserName2"
        
        let app = XCUIApplication()
        app.navigationBars["BoardBank"].buttons["Add"].tap()
        
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.textFields["Player"].exists)
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Player"]/*[[".cells.staticTexts[\"Add Player\"]",".staticTexts[\"Add Player\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.collectionViews/*[[".cells.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.cells.otherElements.containing(.image, identifier:"thimble").element.exists)
        
        tablesQuery.textFields["Player"].tap()
        
        //don't know how make typeText more beatiful
        let playerNameField = tablesQuery.textFields["Player"]
        playerNameField.typeText(userNameTwo)
        
        //check name text field
        let textField = tablesQuery.cells.containing(.textField, identifier:userNameTwo).children(matching: .textField).element
        XCTAssertTrue(textField.exists)
        
        //select thimble
        tablesQuery/*@START_MENU_TOKEN@*/.collectionViews/*[[".cells.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.cells.otherElements.containing(.image, identifier:"thimble").element.tap()
        
        //add & save player
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Player"]/*[[".cells.staticTexts[\"Add Player\"]",".staticTexts[\"Add Player\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //check saved new playerOne
        XCTAssertTrue(app.collectionViews.staticTexts[userNameTwo].exists)
        
    }
    func test04PlayerTwoGetExtra200() {
        
        let app = XCUIApplication()
        let playerOneCell = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["UserName1"]/*[[".cells.staticTexts[\"UserName1\"]",".staticTexts[\"UserName1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(playerOneCell.exists)
        playerOneCell.tap()
        
        //add $200 to playerOne
        sleep(1)
        app.sheets["UserName1: $1.200"].buttons["Add $200"].tap()
        sleep(1)
        playerOneCell.tap()
        
        //check new value
        XCTAssertTrue(app.sheets["UserName1: $1.400"].staticTexts["UserName1: $1.400"].exists)
        
    }
    func test05PlayerOneDeletedFromGame() {
        
        let app = XCUIApplication()
        
        //select playerTwo
        let playerTwoCell = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"UserName2").children(matching: .other).element
        XCTAssertTrue(playerTwoCell.exists)
        playerTwoCell.tap()
        
        //delete playerTwo add sleep as menu opening have delay
        sleep(1)
        app.sheets["UserName2: $1.500"].buttons["Delete"].tap()
        sleep(1)
        XCTAssertFalse(playerTwoCell.exists)
        
    }
}
