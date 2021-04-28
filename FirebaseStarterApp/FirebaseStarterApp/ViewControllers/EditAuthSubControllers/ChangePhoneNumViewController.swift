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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func callAlart(title: String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onReturn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var newPhoneNum: UITextField!
    
    @IBAction func onSubmit(_ sender: Any) {
        if (self.newPhoneNum.text == nil) {
            self.callAlart(title: "Missing Phone Number", message: "Please Input a Valid Phone Number")
        } else {
            var verificationId: String?
            
            PhoneAuthProvider.provider().verifyPhoneNumber(self.newPhoneNum.text!, uiDelegate: nil) { (verificationID, Error) in
                if let error = Error {
                    self.callAlart(title: "Error", message: "Unable to retrive verification Info")
                } else {
                    verificationId = verificationID
                }
            }
            
            self.showInputDialog(title: "Verification", subtitle: "We've send a verification code to your phone. Please type in the code in your SMS message to continue", actionTitle: "Submit", cancelTitle: "Cancel", inputPlaceholder: "Your Code", inputKeyboardType: .default) { (UIAlertAction) in
                return
            } actionHandler: { (Code) in
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId!, verificationCode: Code!)
                Auth.auth().currentUser?.updatePhoneNumber(credential, completion: { (error) in
                    if let error = error {
                        self.callAlart(title: "Invalid Code", message: "Please verify your input")
                    } else {
                        self.callAlart(title: "Change Successful", message: "You have successfully changed your phone number!")
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                })
            }
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
