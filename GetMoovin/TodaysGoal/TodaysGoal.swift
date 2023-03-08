//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import GetMoovinStepCountModule
import SwiftUI


struct TodaysGoal: View {
    let notify = NotificationHandler()
    
    var body: some View {
        NavigationStack {
            StepCountView()
                .navigationTitle("TODAYS_GOAL_TITLE")
        }
    }
}


#if DEBUG
struct TodaysGoal_Previews: PreviewProvider {
    static var previews: some View {
        TodaysGoal()
            .environmentObject(MockStepCountDataSource(todaysSteps: 1042) as StepCountDataSource)
    }
}
#endif
