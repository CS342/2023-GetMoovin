//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//


import SwiftUI

struct Colors {
    static let primaryColor = Color(hex: "#277DA1")
    static let secondaryColor1 = Color(hex: "#F7CAC9")
    static let secondaryColor2 = Color(hex: "#9BC4CB")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xff0000) >> 16) / 255
        let green = Double((rgbValue & 0xff00) >> 8) / 255
        let blue = Double(rgbValue & 0xff) / 255
        
        self.init(red: red, green: green, blue: blue)
    }
}

// Intialize your own color:
// let myColor = Color(hex: "#000000")
