//
//  NotificationService.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 11.03.2026.
//

import Foundation
import UserNotifications

class NotificationService {
    
    private let center = UNUserNotificationCenter.current()
    
    func requestPermition() async -> Bool {
        let options: UNAuthorizationOptions = [.alert, .sound]
        do {
            let granted = try await center.requestAuthorization(options: options)
            return granted
        } catch {
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func scheduleTimerNotification(at date: Date) {
        let content = setNotificationContent(title: "Время таймера закончилось",
                                             subtitle: "Блок: iOS Dev",
                                             bodyMessage: "Рекомендуется пойти почилить",
                                             sound: UNNotificationSound.default)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: TimerNotificationKeys.timerFinished.rawValue, content: content, trigger: trigger)
        
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            } else {
                print("Succes")
            }
        }
    }
    
    func cancelNotification(for key: TimerNotificationKeys) {
        center.removePendingNotificationRequests(withIdentifiers: [key.rawValue])
    }
    
    func cancelAllNotification() {
        center.removeAllPendingNotificationRequests()
    }
    
    private func setNotificationContent(title: String,
                                subtitle: String,
                                bodyMessage: String,
                                sound: UNNotificationSound, ) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = bodyMessage
        content.sound = sound
        
        return content;
    }
}

enum TimerNotificationKeys: String {
    case timerFinished
}
