//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//


import CardinalKit
import Foundation
import HealthKit


/// <#Description#>
public class StepCountModule<ComponentStandard: Standard>: Component, ObservableObjectProvider {
    private let stepCountDataSource: StepCountDataSource
    
    
    public var observableObjects: [any ObservableObject] {
        [
            stepCountDataSource
        ]
    }
    
    
    /// <#Description#>
    public init() {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" || !HKHealthStore.isHealthDataAvailable() {
            self.stepCountDataSource = MockStepCountDataSource() as StepCountDataSource
        } else {
            self.stepCountDataSource = StepCountDataSource()
        }
    }
}
