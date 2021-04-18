import FirebaseAuth
import UIKit

class ATCClassicLoginScreenViewController: UIViewController {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var passwordTextField: ATCTextField!
  @IBOutlet var contactPointTextField: ATCTextField!
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var backButton: UIButton!
  
  private let backgroundColor = HelperDarkMode.mainThemeBackgroundColor
  private let tintColor = UIColor(hexString: "#ff5a66")
  
  private let titleFont = UIFont.boldSystemFont(ofSize: 30)
  private let buttonFont = UIFont.boldSystemFont(ofSize: 20)
  
  private let textFieldFont = UIFont.systemFont(ofSize: 16)
  private let textFieldColor = UIColor(hexString: "#B0B3C6")
  private let textFieldBorderColor = UIColor(hexString: "#B0B3C6")
  
  private let separatorFont = UIFont.boldSystemFont(ofSize: 14)
  private let separatorTextColor = UIColor(hexString: "#464646")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = backgroundColor
    backButton.setImage(UIImage.localImage("arrow-back-icon", template: true), for: .normal)
    backButton.tintColor = UIColor(hexString: "#282E4F")
    backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    
    titleLabel.font = titleFont
    titleLabel.text = "Log In"
    titleLabel.textColor = tintColor
    
    contactPointTextField.configure(color: textFieldColor,
                                    font: textFieldFont,
                                    cornerRadius: 55/2,
                                    borderColor: textFieldBorderColor,
                                    backgroundColor: backgroundColor,
                                    borderWidth: 1.0)
    contactPointTextField.placeholder = "E-mail"
    contactPointTextField.textContentType = .emailAddress
    contactPointTextField.clipsToBounds = true
    
    passwordTextField.configure(color: textFieldColor,
                                font: textFieldFont,
                                cornerRadius: 55/2,
                                borderColor: textFieldBorderColor,
                                backgroundColor: backgroundColor,
                                borderWidth: 1.0)
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
    passwordTextField.textContentType = .emailAddress
    passwordTextField.clipsToBounds = true
    
    loginButton.setTitle("Log In", for: .normal)
    loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    loginButton.configure(color: backgroundColor,
                          font: buttonFont,
                          cornerRadius: 55/2,
                          backgroundColor: tintColor)
    
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
  
  @objc func didTapLoginButton() {
    let loginManager = FirebaseAuthManager()
    guard let email = contactPointTextField.text, let password = passwordTextField.text else { return }
    loginManager.signIn(email: email, pass: password) {[weak self] (success) in
      self?.showPopup(isSuccess: success)
    }
  }
}
  
extension ATCClassicLoginScreenViewController {
    
    func showPopup(isSuccess: Bool) {
      let successMessage = "User was sucessfully logged in."
      let errorMessage = "Something went wrong. Please try again"
      let alert = UIAlertController(title: isSuccess ? "Success": "Error", message: isSuccess ? successMessage: errorMessage, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
    
    @objc func loginWasSuccessful() {
      let mainVC = ATCClassicMainViewController(nibName: "ATCClassicMainViewController", bundle: nil)
      self.navigationController?.pushViewController(mainVC, animated: true)
    }
}
