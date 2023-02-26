//
//  StepCountViewModel.swift
//  GetMoovin
//
//  Created by Vishnu Ravi on 2/24/23.
//

import Foundation
import HealthKit

class StepCountViewModel: ObservableObject {
    @Published var stepCountToday: Double = 0

    let healthKitManager = HealthKitManager()

    func getStepCount() {
        healthKitManager.getTodaysSteps { steps in
            DispatchQueue.main.async {
                self.stepCountToday = steps
            }
        }
    }
    
}
