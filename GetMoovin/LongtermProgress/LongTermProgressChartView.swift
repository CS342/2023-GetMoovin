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

// New Chart View
struct ChartView: View {
    @State private var weekSteps = Int()
    let stepData = StepCountDataSource()
    let stepWeeks: [StepWeek] = []
    
    // Want to graph step count per week for the most recent 5 weeks
    var body: some View {
        //loop over weeks counting steps per week using sumSteps()
    }
    
    // Produces array of dates for the current week
    func getDaysOfCurrWeek() -> [Date] {
        var dates: [Date] = []
        guard let dateInterval = Calendar.current.dateInterval(of: .weekOfYear, for: Date()) else {
            return dates
        }
        Calendar.current.enumerateDates(startingAfter: dateInterval.start, matching: DateComponents(hour:0), matchingPolicy: .nextTime) {date, _, stop in guard let date = date else {
            return
        }
            if date <= dateInterval.end {
                dates.append(date)
            } else {
                stop = true
            }
        }
        return dates
    }
    
    // Sums steps over a week
    func sumSteps() async {
        var currWeekDates = getDaysOfCurrWeek()
        for currDay in currWeekDates {
            await weekSteps += stepData.steps(forDate: currDay) ?? 0
        }
    }
}

// Old Chart View
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

struct StepWeek: Identifiable {
    var id: ObjectIdentifier
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
