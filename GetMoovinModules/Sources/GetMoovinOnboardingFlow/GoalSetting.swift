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
    @AppStorage(StorageKeys.selectedGoalAnswer) var userSelectedGoal = ""
    
    let questionText = "To get an idea of your daily step count, simply check your phone."
    let answerChoices = ["1000", "5000", "7000", "10000"]
    
    var body: some View {
        VStack {
            HStack {
                Text("GOAL_SETTING_DESCRIPTION", bundle: .module)
                    .font(.title) // Increase font size for better readability
                    .padding() // Add padding for better touch target
                    .bold()
            }
            MultipleChoiceQuestion(
                questionText: questionText,
                choices: answerChoices,
                selectedAnswer: Binding(
                    get: { userSelectedGoal },
                    set: { newValue in
                        userSelectedGoal = newValue
                        saveSelectedGoal(newValue)
                    }
                )
            )
                .font(.title) // Increase font size for better readability
                .padding() // Add padding for better touch target
            
            Spacer()
            
            OnboardingActionsView("GOAL_SETTING_ACTION".moduleLocalized) {
                onboardingSteps.append(.healthKitPermissions)
            }
            .font(.title)
            .padding()
            .padding(.bottom, 20)
            .disabled(userSelectedGoal.isEmpty)
            .accentColor(CustomColor.color2)
        }
        .padding(.horizontal, 24)
        .navigationTitle("GOAL_SETTING_TITLE".moduleLocalized)
    }
    
    init(onboardingSteps: Binding<[OnboardingFlow.Step]>) {
        self._onboardingSteps = onboardingSteps
    }
    
    func saveSelectedGoal(_ newAnswer: String) {
        userSelectedGoal = newAnswer
    }
}

struct GoalSetting_Previews: PreviewProvider {
    @State private static var path: [OnboardingFlow.Step] = []
    
    
    static var previews: some View {
        GoalSetting(onboardingSteps: $path)
    }
}
