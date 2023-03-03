//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

/// Constants shared across the CardinalKit Teamplate Application to access storage information including the `AppStorage` and `SceneStorage`
public enum StorageKeys {
    // MARK: - Onboarding
    /// A `Bool` flag indicating of the onboarding was completed.
    public static let onboardingFlowComplete = "onboardingFlow.complete"
    /// A `Step` flag indicating the current step in the onboarding process.
    public static let onboardingFlowStep = "onboardingFlow.step"
    
    
    // MARK: - Home
    /// The currently selected home tab.
    public static let homeTabSelection = "home.tabselection"
    
    
    // MARK: - User Information
    /// The current information of the user
    public static let userInformation = "userInformation"
    
    /// The user ultimate decade
    public static let userSelectedAnswer = "userSelectedAnswer"
    
    /// The user step goal
    public static let selectedGoalAnswer = "userSelectedGoal"
}
