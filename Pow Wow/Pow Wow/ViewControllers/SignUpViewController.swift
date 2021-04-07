//
//  SignUpViewController.swift
//  Pow Wow
//
//  Created by J6 on 3/24/21.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var firstNameSignUp: UITextField!
    
    @IBOutlet weak var lastNameSignUp: UITextField!
    
    @IBOutlet weak var emailSignUp: UITextField!
    
    @IBOutlet weak var confirmEmailSignUp: UITextField!
    
    @IBOutlet weak var usernameSignUp: UITextField!
    
    @IBOutlet weak var passwordSignUp: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        didTapSignUpButton();
        performSegue(withIdentifier: "signupToLogin", sender: self)
    }
    
    
    @objc func didTapSignUpButton() {
        let signUpManager = FirebaseAuthManager()
        if let email = emailSignUp.text, let password = passwordSignUp.text {
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                } else {
                    message = "There was an error."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }
        }
    }
}
