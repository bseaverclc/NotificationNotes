//
//  ViewController.swift
//  NotificationNotes
//
//  Created by Brian Seaver on 9/6/20.
//  Copyright © 2020 clc.seaver. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func introNotification()
    {
        
    }

    @IBAction func notificationAction(_ sender: UIButton) {
        // Make sure userNotifications is turned on
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            let status = settings.authorizationStatus
            if status == .denied || status == .notDetermined{
                DispatchQueue.main.async {
                    print("\(status)")
                }
            }
            // 1 Create content
            let content = UNMutableNotificationContent()
            content.title = "My Notification"
            content.body = "You clicked the Add Notification Button"
            content.userInfo = ["Step": 0]
            
            //  2 Create Time Trigger
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            // 2.1 Create Calendar Trigger
            var dateComponent = Calendar.current.dateComponents([.hour,.minute,.second], from: Date())
            dateComponent.second = dateComponent.second! + 5
            let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
            
            // 3 Create Request
            let request = UNNotificationRequest(identifier: "Time Request", content: content, trigger: trigger)
            let request2 = UNNotificationRequest(identifier: "Calendar Request", content: content, trigger: trigger2)
          
            // 4 Make Request
            UNUserNotificationCenter.current().add(request2) { (error) in
                if let error = error{
                    print("\(error)")
                }
                print("Created Request")
            }
            
            
        }
    }
    
}

