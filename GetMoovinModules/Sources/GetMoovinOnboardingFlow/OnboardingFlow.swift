//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import GetMoovinSharedContext
import SwiftUI


/// Displays an multi-step onboarding flow for the CS342 2023 GetMoovin Team Application.
public struct OnboardingFlow: View {
    enum Step: String, Codable {
        case information
        case goalSetting
        case healthKitPermissions
        case notifications
    }
    
    
    @SceneStorage(StorageKeys.onboardingFlowStep) private var onboardingSteps: [Step] = []
    
    
    public var body: some View {
        NavigationStack(path: $onboardingSteps) {
            Welcome(onboardingSteps: $onboardingSteps)
                .navigationDestination(for: Step.self) { onboardingStep in
                    switch onboardingStep {
                    case .information:
                        Information(onboardingSteps: $onboardingSteps)
                    case .goalSetting:
                        GoalSetting(onboardingSteps: $onboardingSteps)
                    case .healthKitPermissions:
                        HealthKitPermissions(onboardingSteps: $onboardingSteps)
                    case .notifications:
                        NotificationPermissions()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    public init() {}
}


struct OnboardingFlow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlow()
    }
}
