//
//  BeastSource.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation

import ObjectMapper


// MARK: - ObjectMapper + NSUserDefaults generic data source

class BeastSource<T:BMappable>  {
    
    
    // MARK: - manual key storage
    
    public static func objects(key:String) -> [T]? {
        return BeastNOSQL.mappableObjectsArray(forKey: key, mapper: Mapper<T>())
    }
    
    public static func setObjects(objs:[T]?, key:String) {
        BeastNOSQL.setMappableObjectsArray(value: objs, key: key)
    }
    
    public static func object(key:String) -> T? {
        return BeastNOSQL.mappableObject(forKey: key, mapper: Mapper<T>())
    }
    
    public static func setObject(obj:T?, key:String) {
        BeastNOSQL.setMappableObject(value: obj, key: key)
    }
    
    
    // MARK: - automatic key storage
    
    public static var objs:[T]? {
        
        get {
            return BeastNOSQL.mappableObjectsArray(forKey: String(describing: T.self), mapper: Mapper<T>())
        }
        set(newValue) {
            BeastNOSQL.setMappableObjectsArray(value: newValue, key: String(describing: T.self))
        }
    }
    
    public static var obj:T? {
        
        get {
            return BeastNOSQL.mappableObject(forKey: String(describing: T.self), mapper: Mapper<T>())
        }
        set(newValue) {
            BeastNOSQL.setMappableObject(value: newValue, key: String(describing: T.self))
        }
    }
    
    // MARK: - object wrapper
    
    public static func fromJson(jsonData: AnyObject) -> T? {
        return Mapper<T>().map(JSONObject: jsonData)
    }
    
    public static func arrayFromJson(jsonData: AnyObject) -> [T]? {
        return Mapper<T>().mapArray(JSONObject: jsonData)
    }
}


// MARK: - BeastNOSQL data source

class BeastNOSQL {
    
    
    // MARK: - simple object
    
    public static func object(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    public static func setObject(value: Any?, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    
    // MARK: - mappable single object
    
    public static func setMappableObject<N:BMappable>(value: N?, key: String) {
        
        guard let v = value else {
            setObject(value: nil, key: key)
            return
        }
        setObject(value: Mapper().toJSONString(v), key: key)
    }
    
    public static func mappableObject<N:BMappable>(forKey: String, mapper: Mapper<N>) -> N? {
        return mapper.map(JSONObject: object(key: forKey))
    }
    
    
    // MARK: - mappable objects array
    
    public static func setMappableObjectsArray<N:BMappable>(value: [N]?, key: String) {
        
        guard let v = value else {
            setObject(value: nil, key: key)
            return
        }
        setObject(value: Mapper().toJSONString(v), key: key)
    }
    
    public static func mappableObjectsArray<N:BMappable>(forKey: String, mapper: Mapper<N>) -> [N]? {
        return mapper.mapArray(JSONObject: object(key: forKey))
    }
}
