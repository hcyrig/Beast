//
//  RemoteNotificationManager.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation
import UIKit


let kDeviceToken = "kDeviceToken"

enum RemoteNotificationManagerNames:String {
    case Push = "RemoteNotificationManagerNamesPush"
}

class RemoteNotificationManager {
    
    static var deviceToken:String? {
        
        get{
            return BeastNOSQL.object(key: kDeviceToken) as? String
        }
        set{
            BeastNOSQL.setObject(value: newValue, key: kDeviceToken)
        }
    }
    
    static func registerForPushNotifications() {
        
        //  uncomment if reqistration eash time is not needed
        //  if RemoteNotificationManager.deviceToken()?.isEmpty != nil {
        //     return
        //  }
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            //  SKIP PUSH NOTIFICATIONS IN SIMULATOR
        #else
            let types: UIUserNotificationType = [.Badge,
                                                 .Sound,
                                                 .Alert]
            let settings: UIUserNotificationSettings = UIUserNotificationSettings.init(forTypes: types,
                                                                                       categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        #endif
    }
    
    static func isNotificationsPermissionGranted() -> Bool {
        
        let grantedSettings: UIUserNotificationSettings = UIApplication.shared.currentUserNotificationSettings!
        if grantedSettings.types == .none {
            return false
        }
        return true
    }
    
    static func applicationDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: NSData!) {
        
        var str = deviceToken.description.replacingOccurrences(of: " ", with: "")
        str = deviceToken.description.replacingOccurrences(of: "<", with: "")
        str = deviceToken.description.replacingOccurrences(of: ">", with: "")
        print("\nAPNS TOKEN: " + str)
        
        RemoteNotificationManager.deviceToken = str
    }
    
    static func handleRemoteNotification(userInfo: [AnyHashable : Any],
                                         actionIdent: NSString? = nil) {
        
        if let apsData = userInfo["aps"] as? [AnyHashable : Any] {
            handleRemoteNotificationWithAPS(apsData: apsData)
        }
    }
    
    static func handleRemoteNotificationWithAPS(apsData: [AnyHashable : Any]) {
        handleLocalNotificationWithAPS(apsData: apsData)
    }
    
    
    // MARK: override in ...
    class func handleLocalNotificationWithAPS(apsData: [AnyHashable : Any]) {
        
    }
}
