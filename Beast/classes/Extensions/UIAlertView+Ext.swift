//
//  UIAlertView+Ext.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertView {

    public static func showWithError(error: NSError?) {
        
        let msg = error?.errorDescrioption()
        UIAlertView.init(title: NSLocalizedString("Error", comment: ""),
                         message: msg,
                         delegate: nil,
                         cancelButtonTitle: NSLocalizedString("OK", comment: "")).show()
    }
    
    public static func showWithTitle(title: String?, message: String?) {
        if title != nil ||
            message != nil {
            UIAlertView.init(title: title,
                             message: message,
                             delegate: nil,
                             cancelButtonTitle: NSLocalizedString("OK", comment: "")).show()
        }
    }
}
