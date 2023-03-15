//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Onboarding
import GetMoovinSharedContext
import GetMoovinStepCountModule
import UserNotifications
import SwiftUI

class NotificationSetup {
    
    init() {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
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
        var calendar = Calendar.current
        datComp.hour = calendar.component(.hour, from: date)
        datComp.minute = calendar.component(.minute, from: date)
        datComp.second = 59
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    class DailyNotif {
        @EnvironmentObject var stepCountDataSource: StepCountDataSource
        @AppStorage(StorageKeys.userInformation) var userInformation = UserInformation()
        
        var stepsLeft: Int {
            (userInformation.stepGoal ?? 1000) - (stepCountDataSource.todaysSteps ?? 1000)
        }
        func dailyNotif1() {
            if stepsLeft > 0 {
                let notify = NotificationSetup()
                notify.notificationTrigger()
            }
        }
    }
}
