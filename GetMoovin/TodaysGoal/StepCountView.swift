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
    
    
    var body: some View {
        // this doesnt change anything
        VStack {
            Text("Your current goal is: \(stepGoal) steps/day")
                .padding()
            if stepsLeft <= 0 {
                Text("Congrats! You've met your daily goal")
                if stepsLeft < 0 {
                    Text("Wow, today you exceeded your goal by \(abs(stepsLeft))")
                }
                Button("Take your photo") {
                    showingSheet.toggle()
                }
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .sheet(isPresented: $showingSheet) {
                    SheetView()
                }
            } else {
                Text("You still need \(stepsLeft) steps to reach your goal!")
            }
            VStack {
                DailyProgressCircle(todaysSteps: $todaysSteps)
                    .padding()
            }
            
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
