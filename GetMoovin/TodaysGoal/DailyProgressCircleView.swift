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

struct ProgressCircle: View {
    var progress: Float
    var color = Color.green
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(Animation.easeInOut(duration: 2.0), value: progress)
        }
    }
}

struct DailyProgressCircle: View {
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    @AppStorage(StorageKeys.selectedGoalAnswer) var userSelectedGoal = ""
    
    @Binding var todaysSteps: Int?
    @State private var counter: Int = 0
        
    var progressValue: Float {
        Float(todaysSteps ?? 0) / Float(Int(userSelectedGoal) ?? 10000)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                ProgressCircle(progress: self.progressValue)
                    .frame(width: 140, height: 140)
                    .padding(8)
                    .foregroundColor(.gray.opacity(0.3))
                Text("\(Int(progressValue * 100))%")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
            }
            
            if progressValue < 1.0 {
                Text("Today's Steps")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
                Text("\(todaysSteps ?? 0)")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.blue)
            } else {
                VStack(spacing: 16) {
                    Text("Congratulations!")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Text("You've met your daily goal!")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Button("🎉") { counter += 1 }
                        .confettiCannon(counter: $counter)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(16)
    }
}

struct DailyProgressCircleView_Previews: PreviewProvider {
    @State static var todaysSteps: Int? = 1024
    
    static var previews: some View {
        DailyProgressCircle(todaysSteps: $todaysSteps)
    }
}
