//
//  ATClassicEditAuthViewController.swift
//  FirebaseStarterApp
//
//  Created by 刘淳傲 on 4/23/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import UIKit
import FirebaseAuth

class ATCClassicEditAuthViewController: UIViewController {
    
    func callAlart(title: String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onChangePW(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: (Auth.auth().currentUser?.email!)!) { (_: Error?) in
            self.callAlart(title: "Success", message: "An password reset link has been send to your email. Please check your email and follow the procedure to reset your password.")
            }
    }
    
    @IBAction func onChangeEmail(_ sender: Any) {
        let ChangeEmailVC = ChangeEmailViewController(nibName: "ChangeEmailView", bundle: nil)
        self.navigationController?.pushViewController(ChangeEmailVC, animated: true)
    }
    
    @IBAction func onChangePhoneNum(_ sender: Any) {
        
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
