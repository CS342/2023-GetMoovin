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

struct LongTermProgressChartView: View {
    @EnvironmentObject var stepCountDataSource: StepCountDataSource
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    @AppStorage(StorageKeys.selectedGoalAnswer) var userSelectedGoal = ""
    
    var stepGoal: Int {
        let selectedGoalAnswer = Int(userSelectedGoal) ?? 1000
        return selectedGoalAnswer
    }
    
    let stepMonths: [StepMonth] = [
        .init(date: Date.from(year: 2022, month: 1, day: 1), stepCount: 2000),
        .init(date: Date.from(year: 2022, month: 2, day: 1), stepCount: 3000),
        .init(date: Date.from(year: 2022, month: 3, day: 1), stepCount: 4000),
        .init(date: Date.from(year: 2022, month: 4, day: 1), stepCount: 5000),
        .init(date: Date.from(year: 2022, month: 5, day: 1), stepCount: 11000)
    ]
    
    
    var body: some View {
        VStack {
            Chart {
                ForEach(stepMonths) { stepMonth in
                    BarMark(
                        x: .value("Month", stepMonth.date, unit: .month),
                        y: .value("Views", stepMonth.stepCount)
                    )
                    .foregroundStyle(Color.pink.gradient)
                }
                
                RuleMark(y: .value("Goal", stepGoal))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
            }
            .frame(height: 300)
            .chartXAxis {
                AxisMarks(values: stepMonths.map { $0.date }) { date in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month())
                }
            }
        }
    }
}

struct StepMonth: Identifiable {
    let id = UUID()
    let date: Date
    let stepCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}


struct LongTermProgressChartView_Previews: PreviewProvider {
    static var previews: some View {
        LongTermProgressChartView()
    }
}
