//
//  LoginViewController.swift
//  Twitter
//
//  Created by Raymond Esteybar on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.

//////////////////////////////////////////////////////////////////////////////////
// Part 3: 9:53
//////////////////////////////////////////////////////////////////////////////////

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.bool(forKey: "userLoggedIn")) {
            self.performSegue(withIdentifier: "login_to_home", sender: self)
        }
    }
    
    @IBAction func on_login_button(_ sender: Any) {
        let my_url = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: my_url, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "login_to_home", sender: self)
        }, failure: { (Error) in
            print("Could not log in!")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
