//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Onboarding
import SwiftUI


struct Welcome: View {
    @Binding private var onboardingSteps: [OnboardingFlow.Step]
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 212/255, green: 237/255, blue: 218/255),
                Color(red: 167/255, green: 209/255, blue: 187/255)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            OnboardingView(
                title: "WELCOME_TITLE".moduleLocalized,
                subtitle: "WELCOME_SUBTITLE".moduleLocalized,
                areas: [
                    .init(
                        icon: Image(systemName: "figure.walk"),
                        title: "WELCOME_AREA1_TITLE".moduleLocalized,
                        description: "WELCOME_AREA1_DESCRIPTION".moduleLocalized
                    ),
                    .init(
                        icon: Image(systemName: "chart.bar.fill"),
                        title: "WELCOME_AREA2_TITLE".moduleLocalized,
                        description: "WELCOME_AREA2_DESCRIPTION".moduleLocalized
                    ),
                    .init(
                        icon: Image(systemName: "camera.fill"),
                        title: "WELCOME_AREA3_TITLE".moduleLocalized,
                        description: "WELCOME_AREA3_DESCRIPTION".moduleLocalized
                    )
                ],
                actionText: "WELCOME_BUTTON".moduleLocalized,
                action: {
                    onboardingSteps.append(.information)
                }
            )
        } .edgesIgnoringSafeArea(.all)
        .font(.system(size: 20, weight: .bold))
    }
    
    
    init(onboardingSteps: Binding<[OnboardingFlow.Step]>) {
        self._onboardingSteps = onboardingSteps
    }
}


struct Welcome_Previews: PreviewProvider {
    @State private static var path: [OnboardingFlow.Step] = []
    
    
    static var previews: some View {
        Welcome(onboardingSteps: $path)
    }
}
