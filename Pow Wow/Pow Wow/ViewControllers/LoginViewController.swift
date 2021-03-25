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
        performSegue(withIdentifier: "loginToMain", sender: self)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "loginToSignup", sender: self)
    }
    
    //Liu: I added this to transfer control from your storyboard to my storyboard. In this way we can work on multiple storyboard without merge conflict.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "LoginToMain" {
                guard segue.destination is HomeViewController else { return }
            }
        }
}
