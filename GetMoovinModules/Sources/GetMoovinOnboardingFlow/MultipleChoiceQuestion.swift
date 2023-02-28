//
//  QuestionModels.swift
//  OnboardingFlow
//
//  Created by Natasha Kacharia on 2/26/23.
//

import SwiftUI

struct MultipleChoiceQuestion: View {
    let questionText: String
    let choices: [String]
    @Binding var selectedAnswer: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(questionText)
                .font(.headline)
                .padding(.bottom, 8)
            
            ForEach(choices, id: \.self) { choice in
                Button(action: {
                    selectedAnswer = choice
                }, label: {
                    HStack {
                        Text(choice)
                        Spacer()
                        if selectedAnswer == choice {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                })
                .foregroundColor(.primary)
                .padding(.vertical, 4)
            }
        }
    }
}

struct MultipleChoiceQuestion_Previews: PreviewProvider {
    @State private static var selectedAnswer: String = ""
    static let choices = ["Choice 1", "Choice 2", "Choice 3"]
    
    static var previews: some View {
        MultipleChoiceQuestion(questionText: "What is your ultimate decade?",
                               choices: choices,
                               selectedAnswer: $selectedAnswer)
    }
}

