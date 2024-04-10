//
//  NotificationGenerator.swift
//  EmberLinkIOS
//
//  Created by Loise Study on 2024-04-07.
//
import Foundation
import UserNotifications

class NotificationGenerator {
    static func generateNotification(title: String, description: String) {
        requestAuthorization()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = description
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors
            }
        }
    }
    
    static func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) {granted, error in
            if let error = error {
                // Handle the error here
                print("Error requesting authorization \(error)")
            }
            
            // Enable or disable features based on the authorization
        }
    }
}
