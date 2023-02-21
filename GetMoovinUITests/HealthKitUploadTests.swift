//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import XCTest
import XCTestExtensions
import XCTHealthKit


class HealthKitUploadTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        try disablePasswordAutofill()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["--showOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "GetMoovin")
    }
    
    
    func testHealthKitMockUpload() throws {
        let app = XCUIApplication()
        
        try app.conductOnboardingIfNeeded()
        
        try navigateToMockUpload()
        
        try assertObservationCellPresent(false)
        
        try exitAppAndOpenHealth(.steps)
        
        app.activate()
        
        sleep(5)
        
        try navigateToMockUpload()
        try assertObservationCellPresent(true, pressIfPresent: true)
        try assertObservationCellPresent(true, pressIfPresent: false)
    }
    
    
    private func navigateToMockUpload() throws {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Photo Upload"].waitForExistence(timeout: 2))
        app.tabBars["Tab Bar"].buttons["Photo Upload"].tap()
    }
    
    private func assertObservationCellPresent(_ shouldBePresent: Bool, pressIfPresent: Bool = true) throws {
        let app = XCUIApplication()
        
        let observationText = "/Observation/"
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", observationText)
        
        if shouldBePresent {
            XCTAssertTrue(app.staticTexts.containing(predicate).firstMatch.waitForExistence(timeout: 2))
            if pressIfPresent {
                app.staticTexts.containing(predicate).firstMatch.tap()
            }
        } else {
            XCTAssertFalse(app.staticTexts.containing(predicate).firstMatch.waitForExistence(timeout: 2))
        }
    }
}
