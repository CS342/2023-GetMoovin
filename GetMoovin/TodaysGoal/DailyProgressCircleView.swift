//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import ConfettiSwiftUI
import GetMoovinSharedContext
import GetMoovinStepCountModule
import SwiftUI


struct DailyProgressCircle: View {
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    @AppStorage(StorageKeys.selectedGoalAnswer) var userSelectedGoal = ""
    
    @Binding var todaysSteps: Int?
    @State private var counter: Int = 0
    
    var stepGoal: Int {
        let selectedGoalAnswer = Int(userSelectedGoal) ?? 1000
        return selectedGoalAnswer
    }
        
    var progressValue: Double {
        Double(todaysSteps ?? 0) / Double((Int(userSelectedGoal) ?? stepGoal) )
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                PercentageRing(
                    ringWidth: 50,
                    percent: (self.progressValue * 100),
                    backgroundColor: CustomColor.color1.opacity(0.1),
                    foregroundColors: [CustomColor.color1, CustomColor.color3, CustomColor.color2]
                )
                .scaledToFit()
                .frame(width: 360, height: 280)
                // .previewLayout(.sizeThatFits)
                Text("Today's Steps")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 75)
                Text("\(todaysSteps ?? 0)")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(CustomColor.color2)
            }
            
            if progressValue < 1.0 {
                Text("\(Int(progressValue * 100))%")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(CustomColor.color1)
            } else {
                VStack(spacing: 16) {
                    Text("You've met your daily goal!")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(CustomColor.color1)
                    Button("🎉") { counter += 1 }
                        .confettiCannon(counter: $counter)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
    }
}

struct DailyProgressCircleView_Previews: PreviewProvider {
    @State static var todaysSteps: Int? = 1024
    
    static var previews: some View {
        DailyProgressCircle(todaysSteps: $todaysSteps)
    }
}
