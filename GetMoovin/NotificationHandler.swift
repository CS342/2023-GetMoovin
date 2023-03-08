//
//  NotificationHandler.swift
//  GetMoovin
//
//  Created by Parthav Shergill on 07/03/23.
//


import GetMoovinSharedContext
import GetMoovinStepCountModule
import Onboarding
import SwiftUI
import UserNotifications

class NotificationHandler {
    
    func sendReminder() -> some View {
        let notificationContent = UNMutableNotificationContent()
        var datComp = DateComponents()
        let date = Date()
        
        
        notificationContent.title = "Time to go on your daily walk!"
        notificationContent.body = "It's time to GetMoovin!"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
        datComp.hour = Calendar.current.component(.hour, from: date)
        datComp.minute = Calendar.current.component(.minute, from: date)
        datComp.second = 59
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        
        let request = UNNotificationRequest(identifier: "ID1", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        
        return EmptyView()
    }
    
    func sendAlert() -> some View {
        let notificationContent = UNMutableNotificationContent()
        let date = Date()
        
        notificationContent.title = "Remember to send a photo to your family!"
        notificationContent.body = "Great job completing your goal for the day!"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "ID2", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        
        return EmptyView()
    }
    
}
