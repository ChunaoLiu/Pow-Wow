//
//  ChangeEmailViewController.swift
//  FirebaseStarterApp
//
//  Created by 刘淳傲 on 4/23/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import UIKit
import FirebaseAuth

extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}

class ChangeEmailViewController: UIViewController {
    
    @IBOutlet weak var FirstEmail: UITextField!
    @IBOutlet weak var SecondEmail: UITextField!
    
    func callAlart(title: String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onReturn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onSubmit(_ sender: Any) {
        var complete = false
        if (FirstEmail.text == nil) {
            self.callAlart(title: "Missing Email", message: "Please Input your Email")
        }
        else if (SecondEmail.text == nil) {
            self.callAlart(title: "Missing Email", message: "Please input your Email verification")
        }
        else if (FirstEmail.text != SecondEmail.text) {
            self.callAlart(title: "Email does not match", message: "The two email inputed are not the same. Please verify your input")
        }
        else {
            self.showInputDialog(title: "Verification", subtitle: "We need to verify your password to change your email", actionTitle: "Submit", cancelTitle: "Cancel", inputPlaceholder: "Your Password", inputKeyboardType: .default) { (UIAlertAction) in
                return
            } actionHandler: { (Password) in
                let credential = EmailAuthProvider.credential(withEmail: (Auth.auth().currentUser?.email)!, password: Password!)
                Auth.auth().currentUser?.reauthenticate(with: credential, completion: { whatever,error  in
                    if error != nil {
                        self.callAlart(title: "Verification Failed", message: "Please check your password or account")
                        return
                    }
                    else {
                        Auth.auth().currentUser?.updateEmail(to: self.FirstEmail.text!, completion: { Error in
                            if Error != nil {
                                self.callAlart(title: "Error", message: Error.debugDescription)
                            } else {
                                self.callAlart(title: "Success", message: "Email Change Successful")
                                complete = true
                                return
                            }
                        })
                    }
                })
            }
        }
        if (complete) {
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
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
