//
//  ChangePhoneNumViewController.swift
//  FirebaseStarterApp
//
//  Created by 刘淳傲 on 4/23/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChangePhoneNumViewController: UIViewController {
    
    func callAlart(title: String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var newPhoneNum: UITextField!
    
    @IBAction func onSubmit(_ sender: Any) {
        if (self.newPhoneNum.text == nil) {
            self.callAlart(title: "Missing Phone Number", message: "Please Input a Valid Phone Number")
        } else {
            
        }
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
