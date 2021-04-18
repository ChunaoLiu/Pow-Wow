//
//  ATCClassicProfileViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 3/26/21.
//

import UIKit

class ATCClassicProfileViewController: UIViewController {

    @IBOutlet weak var PersonIcon: UIImageView!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var ProfileBio: UILabel!
    @IBOutlet weak var Banner: UIImageView!
    
    @IBAction func ToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ToEdit(_ sender: Any) {
        performSegue(withIdentifier: "ProfileEditSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProfileEditSegue") {
            if let editPage = segue.destination as? ATCClassicEditProfileViewController {
                editPage.previous_Name = self.ProfileName.text!
                editPage.previous_Bios = self.ProfileBio.text!
                if (self.Banner.image != nil) {
                    editPage.previous_banner = self.Banner.image!
                }
                if (self.PersonIcon.image != nil) {
                    editPage.previous_icon = self.PersonIcon.image!
                }
            }
        }
    }
    
    // This can make the profile icon a circle
    func makeRounded(ProfileImage: UIImageView) {
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.masksToBounds = false
        ProfileImage.layer.borderColor = UIColor.black.cgColor
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        ProfileImage.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("The center of phone is: \(view.center.x) + \(view.center.y)")
        print("The center of banner is: \(Banner.center.x) + \(Banner.center.y)")
        makeRounded(ProfileImage: PersonIcon)
        self.PersonIcon.draw(CGRect(x: self.Banner.center.x/2, y: self.Banner.center.y, width: 130, height: 130))

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
