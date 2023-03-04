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

class OnboardingTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["--showOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "GetMoovin")
    }
    
    
    func testOnboardingFlow() throws {
        let app = XCUIApplication()
        
        try app.navigateOnboardingFlow()
        
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.buttons["Today's Goal"].waitForExistence(timeout: 2))
        tabBar.buttons["Today's Goal"].tap()
        XCTAssertTrue(tabBar.buttons["Progress"].waitForExistence(timeout: 2))
        tabBar.buttons["Progress"].tap()
    }
}


extension XCUIApplication {
    func conductOnboardingIfNeeded() throws {
        if self.staticTexts["GetMoovin"].waitForExistence(timeout: 5) {
            try navigateOnboardingFlow()
        }
    }
    
    func navigateOnboardingFlow() throws {
        try navigateOnboardingFlowWelcome()
        try navigateOnboardingFlowInformation()
        try navigateOnboardingFlowGoalSetting()
        try navigateOnboardingFlowHealthKitAccess()
    }
    
    private func navigateOnboardingFlowWelcome() throws {
        XCTAssertTrue(staticTexts["GetMoovin"].waitForExistence(timeout: 2))
        
        XCTAssertTrue(buttons["Start"].waitForExistence(timeout: 2))
        buttons["Start"].tap()
    }
    
    private func navigateOnboardingFlowInformation() throws {
        XCTAssertTrue(buttons["Next"].waitForExistence(timeout: 2))
        
        // Check that the answer choices are displayed
        XCTAssertTrue(buttons["60-69"].exists)
        XCTAssertTrue(buttons["70-79"].exists)
        XCTAssertTrue(buttons["80-89"].exists)
        XCTAssertTrue(buttons["90-99"].exists)
        
        // Select an answer
        buttons["70-79"].tap()
        
        // Check that the next button is enabled
        XCTAssertTrue(buttons["Next"].isEnabled)
        
        // Tap the next button
        buttons["Next"].tap()
    }
    
    private func navigateOnboardingFlowGoalSetting() throws {
        XCTAssertTrue(buttons["Next"].waitForExistence(timeout: 2))
        
        // Check that the answer choices are displayed
        XCTAssertTrue(buttons["1000"].exists)
        XCTAssertTrue(buttons["5000"].exists)
        XCTAssertTrue(buttons["7000"].exists)
        XCTAssertTrue(buttons["10,000"].exists)
        
        // Select an answer
        buttons["1000"].tap()
        
        // Check that the next button is enabled
        XCTAssertTrue(buttons["Next"].isEnabled)
        
        // Tap the next button
        buttons["Next"].tap()
    }
    
    private func navigateOnboardingFlowHealthKitAccess() throws {
        XCTAssertTrue(staticTexts["HealthKit Access"].waitForExistence(timeout: 2))
        
        XCTAssertTrue(buttons["Grant Access"].waitForExistence(timeout: 2))
        buttons["Grant Access"].tap()
        
        try handleHealthKitAuthorization()
    }
}
