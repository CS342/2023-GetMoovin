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


struct NotificationPermissions: View {
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    
    var body: some View {
        OnboardingView(
            contentView: {
                VStack {
                    OnboardingTitleView(
                        title: "NOTIFICATION_PERMISSIONS_TITLE".moduleLocalized,
                        subtitle: "NOTIFICATION_PERMISSIONS_SUBTITLE".moduleLocalized
                    )
                    .accentColor(CustomColor.color2)
                    Spacer()
                    Image(systemName: "text.bubble")
                        .font(.system(size: 120))
                        .foregroundColor(.accentColor)
                        .accentColor(CustomColor.color2)
                    Text("NOTIFICATION_PERMISSIONS_DESCRIPTION", bundle: .module)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                    Spacer()
                }
            }, actionView: {
                OnboardingActionsView(
                    "NOTIFICATION_PERMISSIONS_BUTTON".moduleLocalized,
                    action: {
                        askForNotificationPermissions()
                        completedOnboardingFlow = true
                    }
                )
                .font(.title) // Increase font size for better readability
                .padding() // Add padding for better touch target
                .accentColor(CustomColor.color2)
            }
        )
    }
    
    
    private func askForNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
            // Enable or disable features based on the authorization.
        }
    }
}


struct NotificationPermissions_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermissions()
    }
}
