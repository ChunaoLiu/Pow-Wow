//
//  FeedViewController.swift
//  Pow Wow
//
//  Created by J6 on 3/24/21.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        performSegue(withIdentifier: "signupToLogin", sender: self)
    }
}
