//
//  LoginViewController.swift
//  Twitter
//
//  Created by Raymond Esteybar on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func on_login_button(_ sender: Any) {
        let my_url = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: my_url, success: {
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
