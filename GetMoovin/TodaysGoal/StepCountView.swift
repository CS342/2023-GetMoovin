//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Charts
import GetMoovinOnboardingFlow
import GetMoovinSharedContext
import GetMoovinStepCountModule
import ImageSource
import Onboarding
import SwiftUI
import UserNotifications
    
struct StepsInfo: Identifiable {
    var id = UUID()
    var type: String
    var count: Int
    var color: String
}

struct SheetView: View {
    @State var image: UIImage?
    @EnvironmentObject var stepCountDataSource: StepCountDataSource
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    @AppStorage(StorageKeys.selectedGoalAnswer) var userSelectedGoal = ""

    private var swiftUIImage: Image? {
        image.flatMap {
            Image(uiImage: $0) // swiftlint:disable:this accessibility_label_for_image
        }
    }
    
    var stepGoal: Int {
        let selectedGoalAnswer = Int(userSelectedGoal) ?? 1000
        return selectedGoalAnswer
    }
    
    var stepsLeft: Int {
        _ = Int(userSelectedGoal) ?? 1000
        return max(0, stepGoal - (stepCountDataSource.todaysSteps ?? 0))
    }
    
    var body: some View {
        NavigationStack {
                ImageSource(image: $image)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                    .navigationTitle("Photo Upload")
                    .toolbar {
                        if let swiftUIImage = swiftUIImage {
                            ToolbarItem {
                                ShareLink(
                                    item: swiftUIImage,
                                    subject: Text("GetMoovin 🚶"),
                                    message: Text("I met my daily goal in GetMoovin!"),
                                    preview: SharePreview("GetMoovin 🚶", image: swiftUIImage)
                                )
                            }
                        }
                    }
        }
    }
}

struct StepCountView: View {
    // Properties
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var stepCountDataSource: StepCountDataSource
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    @AppStorage(StorageKeys.selectedGoalAnswer) var userSelectedGoal = ""
    
    @State var todaysSteps: Int?
    @State var showingSheet = false
    
    var stepGoal: Int {
        let selectedGoalAnswer = Int(userSelectedGoal) ?? 1000
        return selectedGoalAnswer
    }
    
    var stepsLeft: Int {
        _ = Int(userSelectedGoal) ?? 1000
        return max(0, stepGoal - (stepCountDataSource.todaysSteps ?? 0))
    }
    
    // Body
    
    var body: some View {
        VStack {
            // Daily Progress Circle
            dailyProgressCircle
            
            // Step Goal Text
            Text("Current step goal: \(stepGoal)")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
            
            // Congratulation or Reminder Text
            if stepsLeft <= 0 {
                VStack(spacing: 20) {
                    if stepsLeft < 0 {
                        exceededGoalText
                    }
                    congratulationsText
                    takePhotoButton
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 20)
                .padding(.horizontal, 20)
            } else {
                reminderText
            }
        }
        .scaleEffect(0.9)
        .refreshable {
            loadStepCount()
        }
        .onAppear {
            loadStepCount()
        }
        .onChange(of: scenePhase) { _ in
            loadStepCount()
        }
    }
    
    // Subviews
    
    private var dailyProgressCircle: some View {
        VStack {
            DailyProgressCircle(todaysSteps: $todaysSteps)
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    
    private var exceededGoalText: some View {
        Text("You have exceeded your goal by \(abs(stepsLeft)) steps today!")
            .font(.headline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
    }
    
    private var congratulationsText: some View {
        Text("Congratulations!")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }
    
    private var takePhotoButton: some View {
        Button("Take your photo") {
            showingSheet.toggle()
        }
        .foregroundColor(.white)
        .font(.title2)
        .padding()
        .background(CustomColor.color2)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .sheet(isPresented: $showingSheet) {
            SheetView()
                .padding(.bottom, 20)
        }
    }
    
    private var reminderText: some View {
        Text("You still need \(stepsLeft) steps to reach your goal!")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .padding(.horizontal, 32)
    }
    
    private func loadStepCount() {
        Task {
            todaysSteps = await stepCountDataSource.todaysSteps
        }
    }
}


#if DEBUG
    struct StepCountView_Previews: PreviewProvider {
        static var previews: some View {
            StepCountView()
                .environmentObject(MockStepCountDataSource(todaysSteps: 1042) as StepCountDataSource)
        }
    }
#endif
