//
//  PushResponseModel.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation

import ObjectMapper


public class PushResponseModel: BMappable  {
    
    public var _id: Int?
    public var _title: String?
    public var alert: String!
    public var messageCode: String!
    
    required public init?(map: Map) {
        mapping(map: map)
    }
    
    public func mapping(map: Map) {
        
        _id <- map["id"]
        _title <- map["title"]
        alert <- map["alert"]
        messageCode <- map["messageCode"]
    }
}
