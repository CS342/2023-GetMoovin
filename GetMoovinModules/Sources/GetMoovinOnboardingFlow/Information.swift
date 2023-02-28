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
    @State private var selectedAnswer: String = ""
    
    let questionText = "In other words, what decade do you think you will die."
    let answerChoices = ["60-69","70-79","80-89","90-99"]
    
    var body: some View {
        VStack {
            HStack {
                Text("INFORMATION_DESCRIPTION", bundle: .module)
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
            
            OnboardingActionsView("INFORMATION_ACTION".moduleLocalized) {
                onboardingSteps.append(.goalSetting)
            }
            .font(.title) // Increase font size for better readability
            .padding() // Add padding for better touch target
        }
        .padding(.horizontal, 24)
        .navigationTitle("INFORMATION_TITLE".moduleLocalized)
        .navigationBarTitleDisplayMode(.inline) // Show title in navigation bar
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

