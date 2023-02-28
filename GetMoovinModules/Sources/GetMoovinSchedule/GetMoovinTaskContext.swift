//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FHIR


/// The context attached to each task in the CS342 2023 GetMoovin Team Application.
///
/// We currently only support `Questionnaire`s, more cases can be added in the future.
public enum PhotoUploadContext: String, Codable {
    case base
    case day0
    case day2
    case day4
}

public enum GetMoovinTaskContext: Codable, Identifiable {
    /// The task schould display a `Questionnaire`.
    case questionnaire(Questionnaire)
    case photoUpload(PhotoUploadContext)
    case photoUnlock(PhotoUploadContext)
    
    
    public var id: String {
        switch self {
        case let .questionnaire(questionnaire):
            return questionnaire.id.description
        case let .photoUpload(photoUploadContext):
            return photoUploadContext.rawValue
        case let .photoUnlock(photoUnlockContext):
            return photoUnlockContext.rawValue
        }
    }
    
    var actionType: String {
        switch self {
        case .questionnaire:
            return String(localized: "TASK_CONTEXT_ACTION_QUESTIONNAIRE", bundle: .module)
        case .photoUpload:
            return String(localized: "TASK_CONTEXT_ACTION_PHOTOUPLOAD", bundle: .module)
        case .photoUnlock:
            return String(localized: "TASK_CONTEXT_ACTION_PHOTOUNLOCK", bundle: .module)
        }
    }
}
