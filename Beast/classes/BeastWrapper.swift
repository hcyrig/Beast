//
//  BeastWrapper.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation


// MARK: - object's manipulator

class BeastWrapper {
    
    public static func stringWithNamesOfObjsByIds(objIds: [Int]?, fromObjs:[AnyObject]) -> String? {
        if objIds == nil { return nil }
        
        if let objs = objsByObjIds(ids: objIds!, fromObjs: fromObjs) {
            if let strings = arrayWithNamesOfObjs(objs: objs) {
                
                let string = strings.joined(separator: ", ")
                return string
            }
        }
        
        return nil
    }
    
    public static func arrayWithNamesOfObjs(objs: [AnyObject]?) -> [String]? {
        if objs == nil { return nil }
        
        var strings: [String] = []
        for (_, obj) in objs!.enumerated() {
            if let model = obj as? BMappable {
                if model._title != nil {
                    strings.append(model._title!)
                }
            }
        }
        return strings
    }
    
    public static func objsByObjIdsInString(idsString: String, fromObjs:[AnyObject]) -> [AnyObject]? {
        
        if let array = objsIdsByObjIdsInString(idsString: idsString) {
            return objsByObjIds(ids: array, fromObjs: fromObjs)
        }
        return []
    }
    
    public static func objsByObjIds(ids: [Int], fromObjs:[AnyObject]) -> [AnyObject]? {
        
        let result = fromObjs.filter { (obj: AnyObject) -> Bool in
            
            if let model = obj as? BMappable {
                if model._id != nil {
                    return ids.contains(model._id!)
                }
            }
            return false
        }
        return result
    }
    
    public static func stringWithIdsOfObjsByIds(objIds: [Int]?) -> String? {
        if objIds == nil { return nil }
        
        var string = objIds!.description
        //if string.characters.count > 2 {
        string = (string as NSString).substring(with: NSRange(location: 1, length: string.characters.count - 2))
        //}
        return string
    }
    
    public static func objsIdsByObjIdsInString(idsString: String?) -> [Int]? {
        
        if idsString == nil { return nil }
        
        var resultArray = [Int]()
        
        if let array = idsString?.replacingOccurrences(of: " ", with: "").components(separatedBy: ",") {
            for string in array {
                if let int = Int(string) {
                    resultArray.append(int)
                }
            }
        }
        return resultArray
    }
}
