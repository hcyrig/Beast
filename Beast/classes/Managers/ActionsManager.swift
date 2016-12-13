//
//  ActionsManager.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation
import MessageUI


public class ActionsManager: NSObject, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    public static let sharedInstance = ActionsManager()
    
    private override init() {
        super.init()
    }
    
    
    // MARK: Phone
    
    public func callURLFromPhoneString(phone: String) -> NSURL? {
        
        let charsSet = CharacterSet(charactersIn: "0123456789-+()").inverted
        let cleanedString = phone.components(separatedBy: charsSet).joined(separator: "")
        let telURL = NSURL(string:"tel://\(cleanedString)")
        return telURL
    }
    
    public func canCallToURL(url: NSURL) -> Bool {
        return UIApplication.shared.canOpenURL(url as URL)
    }
    
    public func callToURL(telURL: NSURL, alertTitle: String, alertMessage: String) {
        
        UIAlertView(title: alertTitle, message: alertMessage, delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "Call").show()
    }
    
    public func share(sender:UIView, objects:[AnyObject],
                      controller:UIViewController,
                      animated:Bool = true,
                      types:[UIActivityType] = [
        .postToFacebook,
        .postToTwitter,
        .postToWeibo,
        .message,
        .mail,
        .print,
        .copyToPasteboard,
        .assignToContact,
        .saveToCameraRoll,
        .addToReadingList,
        .postToFlickr,
        .postToVimeo,
        .postToTencentWeibo,
        .airDrop ]) {
        
        let objectsToShare = objects
        let activityVC = UIActivityViewController(activityItems: objectsToShare,
                                                  applicationActivities: nil)
        
        activityVC.excludedActivityTypes = types
        activityVC.popoverPresentationController?.sourceView = sender
        controller.present(activityVC,
                           animated: animated,
                           completion: nil)
    }
    
    public func send(sms:String = "",
                     recipients:[String] = []) {
        
        if MFMessageComposeViewController.canSendText() == false {
            
            UIAlertView.showWithTitle(title: NSLocalizedString("Error",
                                                               comment: ""),
                                      message: NSLocalizedString("Device can not send text messages",
                                                                 comment: ""))
            return
        }
        
        let messageController = MFMessageComposeViewController()
        messageController.messageComposeDelegate = ActionsManager.sharedInstance
        messageController.recipients = recipients
        messageController.body = sms
        UIApplication.shared.keyWindow?.rootViewController?.present(messageController,
                                                                    animated: true,
                                                                    completion: nil)
    }
    
    public func send(email:String, recipients:[String]) {
        
        if MFMailComposeViewController.canSendMail() == false {
            
            UIAlertView.showWithTitle(title: NSLocalizedString("Error",
                                                               comment: ""),
                                      message: NSLocalizedString("No email account found on this device. Please setup your email account on your device to use this service",
                                                                 comment: ""))
            return
        }
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.setToRecipients(recipients)
        mailComposeVC.setMessageBody(email, isHTML: true)
        UIApplication.shared.keyWindow?.rootViewController?.present(mailComposeVC,
                                                                    animated: true,
                                                                    completion: nil)
        mailComposeVC.mailComposeDelegate = ActionsManager.sharedInstance
    }
    
    
    // MARK: MFMailComposeViewControllerDelegate
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: MFMailComposeViewControllerDelegate
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - open google maps from application by coordinates (lat, lng)
    
    public func openGoogleMaps(point:CGPoint?, shemas:String, name:String) {
        
        guard let p = point else {
            print("point can't be nil")
            return
        }
        
        let requestString = "comgooglemaps-x-callback://?center=\(p.x),\(p.y)&zoom=20&x-success=\(shemas)://?resume=true&x-source=\(name)"
        
        guard let url = NSURL(string: requestString) else {
            print("request call url is emptied")
            return
        }
        openUrl(url: url, title:name,
                message: "Google maps application isn't installed, please will install it to open this activity on.")
    }
    
    
    // MARK: - open application's settings
    
    public func openSettings() {
        openUrl(url: NSURL(string: UIApplicationOpenSettingsURLString))
    }
    
    public func openUrl(url:NSURL?, title:String? = nil, message:String? = nil) {
        if let u = url {
            if UIApplication.shared.canOpenURL(u as URL) {
                UIApplication.shared.openURL(u as URL)
            } else {
                UIAlertView.showWithTitle(title: title, message: message)
            }
        }
    }
}
