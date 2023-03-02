//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Charts
import GetMoovinSharedContext
import GetMoovinStepCountModule
import SwiftUI

struct StepsInfo: Identifiable {
    var id = UUID()
    var type: String
    var count: Int
    var color: String
}

struct StepCountView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var stepCountDataSource: StepCountDataSource
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    
    @State var todaysSteps: Int?
        
    var body: some View {
            VStack {
                if todaysSteps != nil {
                    DailyProgressCircle(todaysSteps: $todaysSteps)

    
    /*var body: some View {
        let data: [StepsInfo] = [
            .init(type: "Steps", count: stepCountDataSource.todaysSteps ?? 7000, color: "Blue"),
            .init(type: "Steps", count: 10000, color: "Grey")
        ]
        Chart {
            ForEach(data) { shape in
                   BarMark(
                       x: .value("Shape Type", shape.type),
                       y: .value("Total Count", shape.count)
                   )
                   .foregroundStyle(by: .value("Shape Color", shape.color))
            }
        }
        ScrollView {
            VStack {
                if let todaysSteps = stepCountDataSource.todaysSteps {
                    Text("Today's step count: \(todaysSteps)")*/
                    
                } else {
                    ProgressView()
                        .padding()
                }
                if let stepGoal = userInformation.stepGoal {
                    Text("The goal is: \(stepGoal)")
                }
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
