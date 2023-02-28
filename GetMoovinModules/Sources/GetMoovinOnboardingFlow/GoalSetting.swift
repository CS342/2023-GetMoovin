//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import GetMoovinSharedContext
import Onboarding
import SwiftUI


struct GoalSetting: View {
    @Binding private var onboardingSteps: [OnboardingFlow.Step]
    
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    
    
    var body: some View {
        VStack {
            Text("GOAL_SETTING_DESCRIPTION", bundle: .module)
            OnboardingActionsView("GOAL_SETTING_ACTION".moduleLocalized) {
                onboardingSteps.append(.healthKitPermissions)
            }
        }
            .padding(.horizontal, 24)
            .navigationTitle("GOAL_SETTING_TITLE".moduleLocalized)
    }
    
    
    init(onboardingSteps: Binding<[OnboardingFlow.Step]>) {
        self._onboardingSteps = onboardingSteps
    }
}


struct GoalSetting_Previews: PreviewProvider {
    @State private static var path: [OnboardingFlow.Step] = []
    
    
    static var previews: some View {
        GoalSetting(onboardingSteps: $path)
    }
}
