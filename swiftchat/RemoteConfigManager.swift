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
    
    static let interval: TimeInterval = 12
    static var remoteConfigValues:[String:String] = [:]
    static var controlsToUpdate:[String:NSObject] = [:]
    
    static func remoteConfigInit(firstControl:UIButton){
        RemoteConfigManager.controlsToUpdate["loginButton"] = firstControl
        
        let remoteValues = RemoteConfig.remoteConfig()
        RemoteConfigManager.remoteConfigValues["loginButton"] = remoteValues["loginButton"].stringValue
        RemoteConfigManager.remoteConfigValues["PhotoButtonUpdate"] = remoteValues["PhotoButtonUpdate"].stringValue
        
        let remoteConfigDefaults:[String:NSObject] = [
            "loginButton":"login" as NSObject,
            "PhotoButtonUpdate":"update" as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(remoteConfigDefaults)
        
        //43200 = 12 hours
        Timer.scheduledTimer(timeInterval: RemoteConfigManager.interval, target: self, selector: #selector(RemoteConfigManager.startFetching(firstControl:)), userInfo: nil, repeats: true)
        
        remoteConfigDebugMode()
        startFetching(firstControl: firstControl)
        
        
    }
    
    @objc static func startFetching(firstControl:UIButton){
        let remoteValues = RemoteConfig.remoteConfig()
        RemoteConfigManager.remoteConfigValues["loginButton"] = remoteValues["loginButton"].stringValue
        RemoteConfigManager.remoteConfigValues["PhotoButtonUpdate"] = remoteValues["PhotoButtonUpdate"].stringValue
        
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: RemoteConfigManager.interval){
            (status, error) in
            guard error == nil else {
                print("Error fetching remote config values \(error)")
                return
            }
            
            RemoteConfig.remoteConfig().activateFetched()
            let fc = RemoteConfigManager.controlsToUpdate["loginButton"] as! UIButton
            print("loginButton value: \(RemoteConfigManager.remoteConfigValues["loginButton"])")
            fc.setTitle(RemoteConfigManager.remoteConfigValues["loginButton"], for: UIControlState.normal)
        }
    }
    
    static func remoteConfigDebugMode() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings!
    }
}

