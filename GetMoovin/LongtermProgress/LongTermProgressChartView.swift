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

struct ChartView: View {
    let stepData = StepCountDataSource()
    @State var stepWeeks: [StepWeek] = []
    @EnvironmentObject var stepCountDataSource: StepCountDataSource
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    @AppStorage(StorageKeys.selectedGoalAnswer) var userSelectedGoal = ""

    var stepGoal: Int {
        let selectedGoalAnswer = Int(userSelectedGoal) ?? 1000
        return selectedGoalAnswer
    }

    var body: some View {
        VStack {
            Chart {
                ForEach(stepWeeks) { stepWeek in
                    BarMark(
                        x: .value("Week", stepWeek.date, unit: .weekOfMonth),
                        y: .value("Views", stepWeek.stepCount)
                    )
                    .foregroundStyle(CustomColor.color3)
                }

                RuleMark(y: .value("Goal", stepGoal * 7))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
            }
            .scaleEffect(0.85)
            .frame(width: 350, height: 300)
                        .scaledToFit()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(20)
            MotivationalQuote()
                .scaleEffect(0.9)
        }
            .task {
                await getLastFiveWeeks()
            }
    }

    // Produces array of dates for the current week
    func getLastFiveWeeks() async {
        stepWeeks.removeAll()
        var dates: [Date] = []
        for index in -5...0 {
            dates.append(Date.now.addingTimeInterval(Double((60 * 60 * 24 * 7) * index)))
        }
        for date in dates {
            let stepCount = await stepData.stepsInTheWeek(forDate: date)
            stepWeeks.append(StepWeek(date: date, stepCount: stepCount ?? 0))
        }
    }
}

struct StepWeek: Identifiable {
    var id = UUID()
    let date: Date
    let stepCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
