//
//  BMappable+Ext.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation

import ObjectMapper

protocol BMappable:Mappable {
    
    var _id:Int? { get }
    var _title:String? { get }
}
