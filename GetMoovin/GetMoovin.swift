//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import GetMoovinOnboardingFlow
import GetMoovinSharedContext
import SwiftUI


@main
struct GetMoovin: App {
    @UIApplicationDelegateAdaptor(GetMoovinAppDelegate.self) var appDelegate
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false

    var body: some Scene {
        WindowGroup {
            HomeView()
                .sheet(isPresented: !$completedOnboardingFlow) {
                    OnboardingFlow()
                }
                .testingSetup()
                .cardinalKit(appDelegate)
        }
    }
}
