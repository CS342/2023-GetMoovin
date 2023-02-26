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
        
        XCTAssertTrue(app.staticTexts["GetMoovin!"].waitForExistence(timeout: 5))
    }
}


extension XCUIApplication {
    func conductOnboardingIfNeeded() throws {
        if self.staticTexts["CardinalKit\nGetMoovin Application"].waitForExistence(timeout: 5) {
            try navigateOnboardingFlow()
        }
    }
    
    func navigateOnboardingFlow() throws {
        try navigateOnboardingFlowWelcome()
        try navigateOnboardingFlowInterestingModules()
        try navigateOnboardingFlowHealthKitAccess()
    }
    
    private func navigateOnboardingFlowWelcome() throws {
        XCTAssertTrue(staticTexts["CardinalKit\nGetMoovin Application"].waitForExistence(timeout: 2))
        
        XCTAssertTrue(buttons["Learn More"].waitForExistence(timeout: 2))
        buttons["Learn More"].tap()
    }
    
    private func navigateOnboardingFlowInterestingModules() throws {
        XCTAssertTrue(staticTexts["Interesting Modules"].waitForExistence(timeout: 2))
        
        for _ in 1..<4 {
            XCTAssertTrue(buttons["Next"].waitForExistence(timeout: 2))
            buttons["Next"].tap()
        }
        
        XCTAssertTrue(buttons["Next"].waitForExistence(timeout: 2))
        buttons["Next"].tap()
    }
    
    private func navigateOnboardingFlowHealthKitAccess() throws {
        XCTAssertTrue(staticTexts["HealthKit Access"].waitForExistence(timeout: 2))
        
        XCTAssertTrue(buttons["Grant Access"].waitForExistence(timeout: 2))
        buttons["Grant Access"].tap()
        
        try handleHealthKitAuthorization()
    }
}
