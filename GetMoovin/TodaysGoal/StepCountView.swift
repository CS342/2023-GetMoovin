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
    @State var changeGoalSheet = false
    
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
            HStack (
                alignment: .center,
                spacing: 17) {
                // Step Goal Text
                Text("STEP GOAL: \(stepGoal)")
                    .font(.title3.bold())
                    .foregroundColor(CustomColor.color1)
                changeGoalButton
            }
            .frame(width: 385, height: 80)
            .scaledToFit()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(20)
            .padding(.bottom, 8)
            // Daily Progress Circle
            dailyProgressCircle
            // Congratulation or Reminder Text
            VStack {
                if stepsLeft <= 0 {
                    VStack(alignment: .center) {
                        if stepsLeft < 0 {
                            exceededGoalText
                        }
                        congratulationsText
                            .padding(.top, 20)
                        takePhotoButton
                    }
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 20)
                    .padding(.horizontal, 20)
                } else {
                    reminderText
                }
            }
            .frame(width: 385, height: 150)
            .scaledToFit()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(20)
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
        .padding(.top, 15)
    }
        
    
    // Subviews
    
    private var dailyProgressCircle: some View {
        VStack {
            DailyProgressCircle(todaysSteps: $todaysSteps)
                .padding(.bottom, 8)
        }
    }
    
    private var exceededGoalText: some View {
        Text("You have exceeded your goal by \(abs(stepsLeft)) steps today!")
            .font(.headline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
    }
    
    private var changeGoalButton: some View {
        Button("Change Goal") {
            changeGoalSheet.toggle()
            changeGoalSheet = true
        }
        .foregroundColor(CustomColor.color2)
        .font(.title3)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(CustomColor.color2, lineWidth: 2).frame(width: 135, height: 35))
        .padding()
        .sheet(isPresented: $changeGoalSheet) {
            ChangeGoal()
                .padding(.bottom, 20)
            Button("Dismiss") {
                changeGoalSheet = false
            }
            .foregroundColor(.white)
            .font(.title3)
            .padding()
            .background(CustomColor.color2)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
    }
    
    private var congratulationsText: some View {
        Text("Congratulations!")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(CustomColor.color1)
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
            Button("Dismiss") {
                showingSheet = false
            }
            .foregroundColor(.white)
            .font(.title3)
            .padding()
            .background(CustomColor.color2)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
    }
    
    private var reminderText: some View {
        Text("You still need \(stepsLeft) steps to reach your goal!")
            .font(.title3)
            .multilineTextAlignment(.center)
            .fontWeight(.semibold)
            .foregroundColor(CustomColor.color1)
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
