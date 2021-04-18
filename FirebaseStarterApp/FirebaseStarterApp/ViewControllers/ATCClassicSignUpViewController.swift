import UIKit

class ATCClassicSignUpViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nameTextField: ATCTextField!
    @IBOutlet var phoneNumberTextField: ATCTextField!
    @IBOutlet var passwordTextField: ATCTextField!
    @IBOutlet var emailTextField: ATCTextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var signUpButton: UIButton!

    private let tintColor = UIColor(hexString: "#ff5a66")
    private let backgroundColor: UIColor = HelperDarkMode.mainThemeBackgroundColor
    private let textFieldColor = UIColor(hexString: "#B0B3C6")
    
    private let textFieldBorderColor = UIColor(hexString: "#B0B3C6")

    private let titleFont = UIFont.boldSystemFont(ofSize: 30)
    private let textFieldFont = UIFont.systemFont(ofSize: 16)
    private let buttonFont = UIFont.boldSystemFont(ofSize: 20)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        let color = UIColor(hexString: "#282E4F")
        backButton.tintColor = color
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        titleLabel.font = titleFont
        titleLabel.text = "Sign Up"
        titleLabel.textColor = tintColor

        nameTextField.configure(color: textFieldColor,
                                font: textFieldFont,
                                cornerRadius: 40/2,
                                borderColor: textFieldBorderColor,
            backgroundColor: backgroundColor,
            borderWidth: 1.0)
        nameTextField.placeholder = "Full Name"
        nameTextField.clipsToBounds = true

        emailTextField.configure(color: textFieldColor,
                                 font: textFieldFont,
                                 cornerRadius: 40/2,
                                 borderColor: textFieldBorderColor,
            backgroundColor: backgroundColor,
            borderWidth: 1.0)
        emailTextField.placeholder = "E-mail Address"
        emailTextField.clipsToBounds = true

        phoneNumberTextField.configure(color: textFieldColor,
                                       font: textFieldFont,
                                       cornerRadius: 40/2,
                                       borderColor: textFieldBorderColor,
            backgroundColor: backgroundColor,
            borderWidth: 1.0)
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.clipsToBounds = true

        passwordTextField.configure(color: textFieldColor,
                                    font: textFieldFont,
                                    cornerRadius: 40/2,
                                    borderColor: textFieldBorderColor,
                                    backgroundColor: backgroundColor,
                                    borderWidth: 1.0)
            passwordTextField.placeholder = "Password"
            passwordTextField.isSecureTextEntry = true
            passwordTextField.clipsToBounds = true

        signUpButton.setTitle("Create Account", for: .normal)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        signUpButton.configure(color: backgroundColor,
                               font: buttonFont,
                               cornerRadius: 40/2,
                               backgroundColor: UIColor(hexString: "#ff5a66"))

        self.hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func callAlart(title: String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

    @objc func didTapSignUpButton() {
        let signUpManager = FirebaseAuthManager()
        let UserDataManager = FirebaseDataAccessManager()
        if (emailTextField.text == "") {
            self.callAlart(title: "Missing email", message: "Please Write down your email address")
        }
        else if (passwordTextField.text == "") {
            self.callAlart(title: "Missing password", message: "Please Write down your email address")
        }
        else if (nameTextField.text == "") {
            self.callAlart(title: "Missing Name", message: "Please Write down your Full Name")
        }
        if (!self.validateEmail(enteredEmail: emailTextField.text!)) {
            let alertController = UIAlertController(title: "Invalid Email", message: "Please check your email address", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        else {
        if let email = emailTextField.text, let password = passwordTextField.text,
           let UserName = nameTextField.text, let UserPhone = phoneNumberTextField.text{
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                let UserCreationStatus = UserDataManager.addNewUser(UserName: UserName, UserEmail: email, UserPhoneNum: Int(UserPhone) ?? 0)
                if (!UserCreationStatus) {
                    self?.callAlart(title: "Error", message: "User Creation Error. Call Admin for help.")
                }
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

    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
}
