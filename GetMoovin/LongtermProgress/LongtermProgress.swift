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


struct LongtermProgress: View {
    @EnvironmentObject var stepCountDataSource: StepCountDataSource
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    
    
    var body: some View {
        NavigationStack {
            Text("LONGTERM_PROGRESS_DESCRIPTION")
                .navigationTitle("LONGTERM_PROGRESS_TITLE")
        }
    }
}


#if DEBUG
struct LongtermProgress_Previews: PreviewProvider {
    static var previews: some View {
        LongtermProgress()
            .environmentObject(MockStepCountDataSource(todaysSteps: 1042) as StepCountDataSource)
    }
}
#endif
