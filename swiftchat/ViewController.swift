//
//  ViewController.swift
//  swiftchat
//
//  Created by Travis Cunningham on 11/16/17.
//  Copyright © 2017 Travis Cunningham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func loginButton_click(_ sender: Any) {
        let email = "travis@enviral.io"
        let password = "password"
        FirebaseManager.Login(email: email, password: password) { (success:Bool) in
            if(success) {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

