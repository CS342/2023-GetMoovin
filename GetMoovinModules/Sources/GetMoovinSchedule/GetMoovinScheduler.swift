//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FHIR
import Foundation
import Scheduler


/// A `Scheduler` using the `FHIR` standard as well as the ``GetMoovinTaskContext`` to schedule and manage tasks and events in the
/// CardinalKit GetMoovin Applciation.
public typealias GetMoovinScheduler = Scheduler<FHIR, GetMoovinTaskContext>


extension GetMoovinScheduler {
    /// Creates a default instance of the ``GetMoovinScheduler`` by scheduling the tasks listed below.
    public convenience init() {
        self.init(
            tasks: [
                Task(
                    title: String(localized: "TASK_SOCIAL_SUPPORT_QUESTIONNAIRE_TITLE", bundle: .module),
                    description: String(localized: "TASK_SOCIAL_SUPPORT_QUESTIONNAIRE_DESCRIPTION", bundle: .module),
                    schedule: Schedule(
                        start: Calendar.current.startOfDay(for: Date()),
                        dateComponents: .init(hour: 0, minute: 30), // Every Day at 12:30 AM
                        end: .numberOfEvents(356)
                    ),
                    context: GetMoovinTaskContext.questionnaire(Bundle.module.questionnaire(withName: "SocialSupportQuestionnaire"))
                ),
                Task(
                    title: String(localized: "Take your daily photo!", bundle: .module),
                    description: String(
                        localized: "Congrats on completing your daily workout!",
                        bundle: .module
                    ),
                    schedule: Schedule(
                        start: Calendar.current.startOfDay(for: Date()),
                        dateComponents: .init(hour: 8, minute: 0),
                        end: .numberOfEvents(1)
                    ),
                    context: GetMoovinTaskContext.photoUpload(PhotoUploadContext.base)
                ),
                Task(
                    title: String(localized: "Unlock your reward", bundle: .module),
                    description: String(
                        localized: "After completing your workout, you unlock your daily surprise picture!",
                        bundle: .module
                    ),
                    schedule: Schedule(
                        start: Calendar.current.startOfDay(for: Date()),
                        dateComponents: .init(hour: 8, minute: 0),
                        end: .numberOfEvents(1)
                    ),
                    context: GetMoovinTaskContext.photoUpload(PhotoUploadContext.day0)
                )
            ]
        )
    }
}
