//
//  User.swift
//  swiftchat
//
//  Created by Travis Cunningham on 11/17/17.
//  Copyright © 2017 Travis Cunningham. All rights reserved.
//

import UIKit

class User: NSObject {
    var username:String
    var email:String
    var uid:String
    var profileImageUrl:String
    
    init(uid:String, username:String, email:String, profileImageUrl:String){
        self.uid = uid
        self.username = username
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
    
}

