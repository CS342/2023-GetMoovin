//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import GetMoovinSharedContext
import HealthKit
import Onboarding
import SwiftUI


struct HealthKitPermissions: View {
    @Binding private var onboardingSteps: [OnboardingFlow.Step]
    
    
    var body: some View {
        OnboardingView(
            contentView: {
                VStack {
                    OnboardingTitleView(
                        title: "HEALTHKIT_PERMISSIONS_TITLE".moduleLocalized,
                        subtitle: "HEALTHKIT_PERMISSIONS_SUBTITLE".moduleLocalized
                    )
                    Spacer()
                    Image(systemName: "heart.text.square.fill")
                        .font(.system(size: 150))
                        .foregroundColor(CustomColor.color2)
                    Text("HEALTHKIT_PERMISSIONS_DESCRIPTION", bundle: .module)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                    Spacer()
                }
            }, actionView: {
                OnboardingActionsView(
                    "HEALTHKIT_PERMISSIONS_BUTTON".moduleLocalized,
                    action: {
                        await askForHealthKitPermissions()
                        onboardingSteps.append(.notifications)
                    }
                )
                .font(.title) // Increase font size for better readability
                .padding() // Add padding for better touch target
                .accentColor(CustomColor.color2)
                .padding(.bottom, 40)
            }
        )
    }
    
    init(onboardingSteps: Binding<[OnboardingFlow.Step]>) {
            self._onboardingSteps = onboardingSteps
        }
    
    private func askForHealthKitPermissions() async {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        let healthStore = HKHealthStore()
        
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        
        try? await healthStore.requestAuthorization(toShare: [], read: [stepType])
    }
}


struct HealthKitPermissions_Previews: PreviewProvider {
    @State private static var path: [OnboardingFlow.Step] = []

    static var previews: some View {
        HealthKitPermissions(onboardingSteps: $path)
    }
}
