//
//  ActivityViewController.swift
//  Peach
//
//  Created by Stephen Radford on 30/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ActivityViewController: PeachViewController {
    
    var activities: [Activity] = []
    
    let center = NSUserNotificationCenter.defaultUserNotificationCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pingActivity()
        
        NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "pingActivity", userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        container?.toolbar?.title = "Activity"
    }
    
    // MARK: - Network
    
    func pingActivity() {
        Peach.getActivityFeed { activity, error in
            self.activities = activity
            self.notifyIfNew()
            Peach.markActivityRead()
        }
    }
    
    func notifyIfNew() {
        let newActivities: [Activity] = activities.flatMap { activity in
            if activity.isUnread {
                return activity
            }
            return nil
        }.flatMap { $0 }
        
        if newActivities.count > 1 {
            let notification = NSUserNotification()
            notification.title = "\(newActivities.count) New Notifications"
            center.deliverNotification(notification)
        } else if newActivities.count == 1 {
            let notification = NSUserNotification()
            notification.title = "New Notification"
            var subtitle: String {
                switch newActivities[0].type! {
                case .Like:
                    return "@\(newActivities[0].authorStream!.name) liked your post."
                default:
                    return "\(newActivities[0].message!)"
                }
            }
            notification.subtitle = subtitle
            center.deliverNotification(notification)
        }
    }
    
}
