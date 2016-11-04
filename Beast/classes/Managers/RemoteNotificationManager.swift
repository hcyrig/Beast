//
//  RemoteNotificationManager.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

public enum RemoteNotificationManagerNames:String {
    case Push = "RemoteNotificationManagerNamesPush"
}

public class RemoteNotificationManager {
    
    public static let kDeviceToken = "kDeviceToken"
    
    public static var deviceToken:String? {
        
        get{
            return BeastNOSQL.object(key: kDeviceToken) as? String
        }
        set{
            BeastNOSQL.setObject(value: newValue, key: kDeviceToken)
        }
    }
    
    public static func registerForPushNotifications() {
        
        //  uncomment if reqistration eash time is not needed
        //  if RemoteNotificationManager.deviceToken()?.isEmpty != nil {
        //     return
        //  }
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            //  SKIP PUSH NOTIFICATIONS IN SIMULATOR
        #else
            // iOS 10 support
            if #available(iOS 10, *) {
                UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
                UIApplication.shared.registerForRemoteNotifications()
            }
                // iOS 9 support
            else if #available(iOS 9, *) {
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
                UIApplication.shared.registerForRemoteNotifications()
            }
                // iOS 8 support
            else if #available(iOS 8, *) {
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
                UIApplication.shared.registerForRemoteNotifications()
            }
                // iOS 7 support
            else {
                UIApplication.shared.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
            }
        #endif
    }
    
    public static func isNotificationsPermissionGranted() -> Bool {
        
        let grantedSettings: UIUserNotificationSettings = UIApplication.shared.currentUserNotificationSettings!
        if grantedSettings.types == .none {
            return false
        }
        return true
    }
    
    public static func applicationDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: NSData!) {
        
        var str = deviceToken.description.replacingOccurrences(of: " ", with: "")
        str = deviceToken.description.replacingOccurrences(of: "<", with: "")
        str = deviceToken.description.replacingOccurrences(of: ">", with: "")
        print("\nAPNS TOKEN: " + str)
        
        RemoteNotificationManager.deviceToken = str
    }
    
    public static func handleRemoteNotification(userInfo: [AnyHashable : Any],
                                         actionIdent: NSString? = nil) {
        
        if let apsData = userInfo["aps"] as? [AnyHashable : Any] {
            handleRemoteNotificationWithAPS(apsData: apsData)
        }
    }
    
    public static func handleRemoteNotificationWithAPS(apsData: [AnyHashable : Any]) {
        handleLocalNotificationWithAPS(apsData: apsData)
    }
    
    
    // MARK: override in ...
    public class func handleLocalNotificationWithAPS(apsData: [AnyHashable : Any]) {
        
    }
}
