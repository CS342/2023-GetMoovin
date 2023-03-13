//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//
import GetMoovinSharedContext
import Onboarding
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
                        }
                    }
                })
                .foregroundColor(.primary)
                .padding(.vertical, 4)
            }
        }
    }
}


struct ChangeGoal: View {
    @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
    @AppStorage(StorageKeys.selectedGoalAnswer) var userSelectedGoal = ""
    @State private var showingDismiss = false
    
    let questionText = "To get an idea of your daily step count, simply check your phone."
    let answerChoices = ["1000", "5000", "7000", "10000"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Goal Setting:")
                    .font(.title) // Increase font size for better readability
                    .padding() // Add padding for better touch target
                    .bold()
            }
            MultipleChoiceQuestion(
                questionText: questionText,
                choices: answerChoices,
                selectedAnswer: Binding(
                    get: { userSelectedGoal },
                    set: { newValue in
                        userSelectedGoal = newValue
                        saveSelectedGoal(newValue)
                    }
                )
            )
                .font(.title) // Increase font size for better readability
                .padding() // Add padding for better touch target
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationTitle("Goal Setting:")
    }
    
    func saveSelectedGoal(_ newAnswer: String) {
        userSelectedGoal = newAnswer
    }
}


struct ChangeGoal_Previews: PreviewProvider {
    static var previews: some View {
        ChangeGoal()
    }
}
