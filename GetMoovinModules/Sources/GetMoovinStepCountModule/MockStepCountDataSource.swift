//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// <#Description#>
public class MockStepCountDataSource: StepCountDataSource {
    private let _todaysSteps: Int


    override public var todaysSteps: Int? {
        get async {
            try? await Task.sleep(for: .seconds(2))
            return _todaysSteps
        }
    }


    /// <#Description#>
    /// - Parameter todaysSteps: <#todaysSteps description#>
    public init(todaysSteps: Int = 5422) {
        self._todaysSteps = todaysSteps
        
        super.init()
    }


    override public func steps(forDate date: Date) async -> Int? {
        try? await Task.sleep(for: .seconds(2))
        return .random(in: 1000...20000)
    }

    override public func requestStepAuthorization() async throws {
        try await Task.sleep(for: .seconds(5))
    }
}
