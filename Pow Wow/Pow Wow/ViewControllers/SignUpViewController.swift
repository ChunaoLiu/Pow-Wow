//
//  SignUpViewController.swift
//  Pow Wow
//
//  Created by J6 on 3/24/21.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "signupToLogin", sender: self)
    }
}
