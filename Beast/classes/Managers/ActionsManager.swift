//
//  ActionsManager.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation
import MessageUI


class ActionsManager: NSObject, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    static let sharedInstance = ActionsManager()
    
    private override init() {
        super.init()
    }
    
    
    // MARK: Phone
    
    func callURLFromPhoneString(phone: String) -> NSURL? {
    
        let charsSet = CharacterSet(charactersIn: "0123456789-+()").inverted
        let cleanedString = phone.components(separatedBy: charsSet).joined(separator: "")
        let telURL = NSURL(string:"tel://\(cleanedString)")
        return telURL
    }
    
    func canCallToURL(url: NSURL) -> Bool {
        return UIApplication.shared.canOpenURL(url as URL)
    }
    
    func callToURL(telURL: NSURL, alertTitle: String, alertMessage: String) {
        
        UIAlertView(title: alertTitle, message: alertMessage, delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "Call").show()
    }
    
    
    //MARK: send sms
    
    func sendSMSTo(phone: String) {
        
        if MFMessageComposeViewController.canSendText() == false {
            
            UIAlertView.showWithTitle(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Device can not send text messages", comment: ""))
            return
        }
        
        let messageController = MFMessageComposeViewController()
        messageController.messageComposeDelegate = ActionsManager.sharedInstance
        messageController.recipients = [phone]
        UIApplication.shared.keyWindow?.rootViewController?.present(messageController, animated: true, completion: nil)
    }
    
    func emailTo(recipients: [String]) {
    
        if MFMailComposeViewController.canSendMail() == false {
            
            UIAlertView.showWithTitle(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("No email account found on this device. Please setup your email account on your device to use this service", comment: ""))
            return
        }
    
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.setToRecipients(recipients)
        UIApplication.shared.keyWindow?.rootViewController?.present(mailComposeVC, animated: true, completion: nil)
        mailComposeVC.mailComposeDelegate = ActionsManager.sharedInstance
    }
    
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - open google maps from application by coordinates (lat, lng)

    func openGoogleMaps(point:CGPoint?, shemas:String, name:String) {
    
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
    
    func openSettings() {
        openUrl(url: NSURL(string: UIApplicationOpenSettingsURLString))
    }
    
    func openUrl(url:NSURL?, title:String? = nil, message:String? = nil) {
        if let u = url {
            if UIApplication.shared.canOpenURL(u as URL) {
                UIApplication.shared.openURL(u as URL)
            } else {
                UIAlertView.showWithTitle(title: title, message: message)
            }
        }
    }
}