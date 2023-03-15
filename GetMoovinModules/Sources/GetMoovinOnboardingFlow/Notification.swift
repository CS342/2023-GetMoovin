//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import GetMoovinSharedContext
import GetMoovinStepCountModule
import Onboarding
import SwiftUI
import UserNotifications
// swiftlint:disable legacy_objc_type
class NotificationSetup {
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
        }
    }
    
    
    func notificationTrigger() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Time to go on your daily walk!"
        notificationContent.body = "It's time to GetMoovin!"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
        
        var datComp = DateComponents()
        let date = Date()
        let calendar = Calendar.current
        datComp.hour = calendar.component(.hour, from: date)
        datComp.minute = calendar.component(.minute, from: date)
        datComp.second = 59
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error: Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
}
