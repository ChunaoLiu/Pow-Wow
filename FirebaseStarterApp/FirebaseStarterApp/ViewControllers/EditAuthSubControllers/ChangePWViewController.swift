//
//  ChangePWViewController.swift
//  FirebaseStarterApp
//
//  Created by 刘淳傲 on 4/23/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import UIKit

class ChangePWViewController: UIViewController {

    @IBOutlet weak var NewPassword_1: UITextField!
    @IBOutlet weak var OldPassword: UITextField!
    @IBOutlet weak var NewPassword_2: UITextField!
    
    @IBAction func onSubmit(_ sender: Any) {
        
    }
    
    @IBAction func onReturn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
