//
//  Cache.swift
//  Foodie
//
//  Created by Kh's MacBook on 09.07.2021.
//

import Foundation

class Cache{
    
    class func saveUserToken(token:String?){
        UserDefaults.standard.setValue(token, forKey: Constants.TOKEN)
    }
    
    class func isUserLogged() -> Bool{
        return UserDefaults.standard.string(forKey: Constants.TOKEN) != nil
    }

    class func getUserToken() -> String{
        return UserDefaults.standard.string(forKey: Constants.TOKEN)!
    }
}
