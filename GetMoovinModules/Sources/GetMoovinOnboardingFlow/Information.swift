//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Onboarding
import SwiftUI


struct Information: View {
    @Binding private var onboardingSteps: [OnboardingFlow.Step]
    
    
    var body: some View {
        VStack {
            Text("INFORMATION_DESCRIPTION", bundle: .module)
            OnboardingActionsView("INFORMATION_ACTION".moduleLocalized) {
                onboardingSteps.append(.goalSetting)
            }
        }
            .padding(.horizontal, 24)
            .navigationTitle("INFORMATION_TITLE".moduleLocalized)
    }
    
    
    init(onboardingSteps: Binding<[OnboardingFlow.Step]>) {
        self._onboardingSteps = onboardingSteps
    }
}


struct Information_Previews: PreviewProvider {
    @State private static var path: [OnboardingFlow.Step] = []
    
    
    static var previews: some View {
        Information(onboardingSteps: $path)
    }
}
