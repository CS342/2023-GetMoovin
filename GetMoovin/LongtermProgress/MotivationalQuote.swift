//
//  MotivationalQuote.swift
//  GetMoovin
//
//  Created by Anusheh Chaudry on 3/12/23.
//

import SwiftUI

struct MotivationalQuote: View {
    @State private var randomInt = 0
    @State var showingSheet = false
    
    let quotes = [
    "",
    """
    It doesn’t matter whether you are young or old,the important thing is to be healthy and remember habit is what keeps, so keep moving forward.
    """,
    """
    When you realize today that your future starts tomorrow, you’ll begin to take the necessary steps to make it a healthy one.
    """,
    """
    Progress takes place outside the comfort zone.
    """,
    """
    Exercise doesn’t have to be complicated. It can be as simple as a good walk around the neighborhood with your dog or riding your bicycle to work.
    """,
    """
    Push harder than yesterday if you want a different tomorrow.
    """
    ]

    var body: some View {
        VStack(spacing: 8) {
            Text(quotes[randomInt])
                .padding()
        }
        generateMessageButton
    }
    
    private var generateMessageButton: some View {
        Button("Motivational Message") {
            randomInt = Int.random(in: 1..<quotes.count)
        }
        .foregroundColor(.white)
        .font(.title2)
        .padding()
        .background(CustomColor.color2)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
    }


struct MotivationalQuote_Previews: PreviewProvider {
    static var previews: some View {
        MotivationalQuote()
    }
}
