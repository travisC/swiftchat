//
//  RemoteConfigManager.swift
//  swiftchat
//
//  Created by Travis Cunningham on 11/20/17.
//  Copyright © 2017 Travis Cunningham. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class RemoteConfigManager: NSObject {
    
    static var remoteConfigvalues:[String:String] = [:]
    
    static func remoteConfigInit(firstControl: UIButton){
        let remoteValues = RemoteConfig.remoteConfig()
        RemoteConfigManager.remoteConfigvalues["loginButton"] = remoteValues["loginButton"].stringValue
        RemoteConfigManager.remoteConfigvalues["PhotoButtonUpdate"] = remoteValues["PhotoButtonUpdate"].stringValue
        
        let remoteConfigDefaults:[String:NSObject] = [
            "loginButton":"login" as NSObject,
            "PhotoButtonUpdate":"update" as NSObject
        ]
        
        RemoteConfig.remoteConfig().setDefaults(remoteConfigDefaults)
        
        //43200 = 12 hours
        let interval: TimeInterval = 10
        
        remoteConfigDebugMode()
        startFetching(interval: interval, firstControl: firstControl)
    }
    
    static func startFetching(interval:TimeInterval, firstControl:UIButton){
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: interval){
            (status, error) in
            guard error == nil else {
                print("Error fetching remote config values \(error)")
                return
            }
            
            RemoteConfig.remoteConfig().activateFetched()
            print("loginButton value: \(RemoteConfigManager.remoteConfigvalues["loginButton"])")
            firstControl.setTitle(RemoteConfigManager.remoteConfigvalues["loginButton"], for: UIControlState.normal)
        }
    }
    
    static func remoteConfigDebugMode(){
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings!
        
    }
}
