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
    
    @Binding var todaysSteps: Int?
    @State var stepGoal: Int?
    @State private var counter: Int = 0
        
    var progressValue: Float {
        Float(todaysSteps ?? 0) / Float(stepGoal ?? 10000)
    }
    
    var body: some View {
        VStack {
            if progressValue < 1.0 {
                ProgressCircle(progress: self.progressValue)
                    .frame(width: 160.0, height: 160.0)
                    .padding(20.0)
                Text("Today's step count: \(todaysSteps ?? 0)")
            } else {
                ProgressCircle(progress: self.progressValue)
                    .frame(width: 160.0, height: 160.0)
                    .padding(20.0)
                Text("Today's step count: \(todaysSteps ?? 0)")
                Button("🎉") { counter += 1 }
                    .confettiCannon(counter: $counter)
            }
        }
    }
}


struct DailyProgressCircleView_Previews: PreviewProvider {
    @State static var todaysSteps: Int? = 1024
    
    static var previews: some View {
        DailyProgressCircle(todaysSteps: $todaysSteps)
    }
}
