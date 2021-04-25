//
//  EditProfileViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 4/2/21.
//

import UIKit
import AlamofireImage
import FirebaseAuth

class ATCClassicEditProfileViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var Banner: UIImageView!
    @IBOutlet weak var PersonIcon: UIImageView!
    @IBOutlet weak var PersonName: UITextField!
    @IBOutlet weak var PersonBio: UITextView!
    @IBOutlet weak var PersonKeyword: UITextField!
    var TypeList = ["Business", "Psychology", "Programming", "Gaming", "Meme"]
    
    var selectedType: String?
    
    // Used to check whether the icon or the banner is using the camera
    var BannerPicked: Bool = false
    
    var borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
     
    @IBAction func onSubmit(_ sender: Any) {
        // Todo: Submit the data to server and update user info
        let DataManager = FirebaseDataAccessManager()
        var url_id = "Nothing"
        
        DataManager.updateUserSetting(uid: user!.uid, UserName: self.PersonName.text!, UserBio: self.PersonBio.text!, UserKeyword: self.PersonKeyword.text!) { (success) in
            if (success) {
                DataManager.getUserInfo(uid: user!.uid) { (userData) in
                    url_id = userData["URL_ID"]!
                    DataManager.updateUserIcon(URL_ID: url_id, image: self.PersonIcon.image!) { (success, urlString) in
                        if (success) {
                            print("PersonIcon Upload Success!")
                            print("URL stored into the data is: \(urlString)")
                            DataManager.updateUserIconURL(uid: user!.uid, url: urlString)
                            
                            DataManager.updateUserBanner(URL_ID: url_id, image: self.Banner.image!) { (success, urlString) in
                                if (success) {
                                    print("PersonBanner Upload Success!")
                                    print("URL stored into the data is: \(urlString)")
                                    self.navigationController?.popViewController(animated: true)
                                }
                                DataManager.updateUserBannerURL(uid: user!.uid, url: urlString)
                            }
                        }
                    }
                }
            }
            else {
                print("We're not going anywhere cuz update failed!")
            }
        }
        // To make sure we get uid before we upload, all the code regarding upload must be put inside this closure
    }
    
    @IBAction func onCancel(_ sender: Any) {
        // Todo: Discard User's input and return to profile
        self.navigationController?.popViewController(animated: true)
    }
    
    func makeRounded(ProfileImage: UIImageView) {
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.masksToBounds = false
        ProfileImage.layer.borderColor = UIColor.black.cgColor
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        ProfileImage.clipsToBounds = true
    }
    
    // Upon clicking the image
    @IBAction func onChangeBanner(_ sender: Any) {
        print("Change Banner now!")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        self.BannerPicked = true
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onChangeIcon(_ sender: Any) {
        print("Change Icon now!")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        self.BannerPicked = false
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        if BannerPicked == true {
            Banner.image = scaledImage
        } else {
            PersonIcon.image = scaledImage
        }
        
        self.BannerPicked = false
        
        dismiss(animated: true, completion: nil)
    }
    
    func createAndSetupPickerView(){
        let pickerview = UIPickerView()
        pickerview.delegate = self
        pickerview.dataSource = self
        self.PersonKeyword.inputView=pickerview
    }
    
    // This will change the text field to a picker
    func dismissAndClosePickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(self.dismissAction))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.PersonKeyword.inputAccessoryView = toolBar
    }
    
    @objc func dismissAction(){
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize camera picker parameter
        BannerPicked = false
        
        // Make the text view looks better
        PersonBio.delegate = self
        PersonBio.layer.borderWidth = 0.5
        PersonBio.layer.borderColor = borderColor.cgColor
        PersonBio.layer.cornerRadius = 5.0
        
        // Make a rounded profile icon
        makeRounded(ProfileImage: PersonIcon)
        
        // Simulate a placeholder for textview
        PersonBio.text = "Enter your Bio Here:"
        PersonBio.textColor = UIColor.lightGray

        PersonBio.becomeFirstResponder()

        PersonBio.selectedTextRange = PersonBio.textRange(from: PersonBio.beginningOfDocument, to: PersonBio.beginningOfDocument)
        
        self.createAndSetupPickerView()
        self.dismissAndClosePickerView()
        
        
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Enter your bio here:"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
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

extension ATCClassicEditProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.TypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.TypeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedType = self.TypeList[row]
        self.PersonKeyword.text = self.selectedType
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
