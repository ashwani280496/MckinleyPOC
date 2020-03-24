//
//  UserDefaultsHelper.swift
//  Mckinley
//
//  Created by ASHWANI  KUMAR on 25/03/20.
//  Copyright © 2020 ASHWANI  KUMAR. All rights reserved.
//

import Foundation


class UserDefaultKeys{

    static let isLogin = "isLogin"
    static let token = "token"

}


class UserDefaultsHelper{
    
    internal static func saveStringPreferences(key:String, value:String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey:key)
        userDefaults.synchronize()
    }
    
    internal static func saveBooleanPreferences(key:String, value:Bool){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey:key)
        userDefaults.synchronize()
    }
    
    
    static func readPreferencesString(key : String) -> String?{
        
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: key)!
        
    }
    
    static func readPreferencesBoolean(key : String) -> Bool{
        
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: key)
        
    }
    
}
