//
//  LoginViewController.swift
//  Pow Wow
//
//  Created by J6 on 3/24/21.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "loginToFeed", sender: self)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "loginToSignup", sender: self)
    }
}
