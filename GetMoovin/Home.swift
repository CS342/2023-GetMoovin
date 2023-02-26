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


struct HomeView: View {
    enum Tabs: String {
        case todaysGoal
        case longtermGoal
    }
    
    
    @AppStorage(StorageKeys.homeTabSelection) var selectedTab = Tabs.todaysGoal
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TodaysGoal()
                .tag(Tabs.todaysGoal)
                .tabItem {
                    Label("TODAYS_GOAL_TAB_TITLE", systemImage: "figure.walk")
                }
            LongtermProgress()
                .tag(Tabs.longtermGoal)
                .tabItem {
                    Label("LONGTERM_PROGRESS_TAB_TITLE", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
    }
}


#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MockStepCountDataSource(todaysSteps: 1042) as StepCountDataSource)
    }
}
#endif
