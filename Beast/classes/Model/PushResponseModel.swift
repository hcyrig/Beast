//
//  PushResponseModel.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation

import ObjectMapper


class PushResponseModel: BMappable  {
    
    var _id: Int?
    var _title: String?
    var alert: String!
    var messageCode: String!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        _id <- map["id"]
        _title <- map["title"]
        alert <- map["alert"]
        messageCode <- map["messageCode"]
    }
}
