//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import GetMoovinSharedContext
import GetMoovinStepCountModule
import SwiftUI


struct StepCountView: View {
    @EnvironmentObject var stepCountDataSource: StepCountDataSource
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    
    @State var todaysSteps: Int?
    
    
    var body: some View {
        ScrollView {
            VStack {
                if let todaysSteps {
                    Text("Today's step count: \(todaysSteps)")
                } else {
                    ProgressView()
                }
                if let stepGoal = userInformation.stepGoal {
                    Text("The goal is: \(stepGoal)")
                }
            }
        }
            .refreshable {
                loadStepCount()
            }
            .onAppear {
                loadStepCount()
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
