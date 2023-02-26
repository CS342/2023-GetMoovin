//
//  SwiftUIView.swift
//  GetMoovin
//
//  Created by Vishnu Ravi on 2/24/23.
//

import SwiftUI

struct StepCountView: View {
    @StateObject var vm = StepCountViewModel()

    var body: some View {
        VStack {
            Text("Today's step count: \(Int(vm.stepCountToday))")
        }.onAppear {
            vm.getStepCount()
        }
    }
}

struct StepCountView_Previews: PreviewProvider {
    static var previews: some View {
        StepCountView()
    }
}
