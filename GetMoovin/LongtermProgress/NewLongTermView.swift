//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct NewLongTermView: View {
    @State var pickerSelectedItem = 0

    @State var dataPoints: [[CGFloat]] = [
        [50, 100, 150, 75, 60, 10, 40, 45, 55, 50, 100, 150],
        [150, 100, 50, 75, 60, 10, 40, 45, 55, 50, 100, 150],
        [10, 20, 30, 75, 60, 10, 40, 45, 55, 50, 100, 150]
    ]

    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)

            VStack {
                Picker(selection: $pickerSelectedItem, label: Text("")) {
                    Text("Week").tag(0)
                    Text("Month").tag(1)
                    Text("Year").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 24)
                HStack(spacing: 16) {
                    BarView(value: dataPoints[pickerSelectedItem][0])
                    BarView(value: dataPoints[pickerSelectedItem][1])
                    BarView(value: dataPoints[pickerSelectedItem][2])
                }
                .padding(.top, 24)
            }
        }
    }
}

struct BarView: View {
    var value: CGFloat

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width: 30, height: 200)
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(.white)
            }
            Text("D").padding(.top, 8)
        }
    }
}

struct NewLongTermView_Previews: PreviewProvider {
    static var previews: some View {
        NewLongTermView()
    }
}
