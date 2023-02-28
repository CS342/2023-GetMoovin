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
    @State private var selectedAnswer: String = ""
    
    let questionText = "If you want an idea of your current step count, check your phone."
    let answerChoices = ["500","1000","1500","2000"]
    
    var body: some View {
        VStack {
            HStack {
                Text("GOAL_SETTING_DESCRIPTION", bundle: .module)
                    .font(.title) // Increase font size for better readability
                    .padding() // Add padding for better touch target
                    .frame(maxWidth: .infinity) // Expand to full width
                    .bold()
            }
        
            MultipleChoiceQuestion(questionText: questionText,
                                   choices: answerChoices,
                                   selectedAnswer: $selectedAnswer)
                .font(.title) // Increase font size for better readability
                .padding() // Add padding for better touch target
            
            Spacer()

            OnboardingActionsView("GOAL_SETTING_ACTION".moduleLocalized) {
                onboardingSteps.append(.healthKitPermissions)
            }
            .font(.title) // Increase font size for better readability
            .padding() // Add padding for better touch target
        }
        .padding(.horizontal, 24)
        .navigationTitle("GOAL_SETTING_TITLE".moduleLocalized)
        .navigationBarTitleDisplayMode(.inline) // Show title in navigation bar
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
