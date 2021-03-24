//
//  InitialViewController.swift
//  Pow Wow
//
//  Created by J6 on 3/24/21.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "loginToLogin", sender: self)
    }
}
