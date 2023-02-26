//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation
import HealthKit


/// <#Description#>
public class StepCountDataSource: ObservableObject {
    lazy var healthStore = HKHealthStore()
    
    
    /// <#Description#>
    public var todaysSteps: Int? {
        get async {
            await steps(forDate: .now)
        }
    }
    

    /// <#Description#>
    public init() { }
    
    
    /// <#Description#>
    /// - Parameter date: <#date description#>
    /// - Returns: <#description#>
    public func steps(forDate date: Date) async -> Int? {
        guard HKHealthStore.isHealthDataAvailable() else {
            return nil
        }
        
        // Create a predicate for today's samples.
        let startDate = Calendar.current.startOfDay(for: date)
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
        let today = HKQuery.predicateForSamples(withStart: startDate, end: endDate)

        // Create the query descriptor.
        let stepType = HKQuantityType(.stepCount)
        let stepsToday = HKSamplePredicate.quantitySample(type: stepType, predicate: today)
        let sumOfStepsQuery = HKStatisticsQueryDescriptor(predicate: stepsToday, options: .cumulativeSum)

        // Run the query.
        guard let steps = try? await sumOfStepsQuery.result(for: healthStore)?
            .sumQuantity()?
            .doubleValue(for: HKUnit.count()) else {
            return nil
        }
        
        return Int(steps)
    }
    
    
    /// <#Description#>
    public func requestStepAuthorization() async throws {
        guard HKHealthStore.isHealthDataAvailable() else {
            throw HKError(.errorHealthDataUnavailable)
        }
        
        try await healthStore.requestAuthorization(toShare: [], read: [HKQuantityType(.stepCount)])
    }
}
