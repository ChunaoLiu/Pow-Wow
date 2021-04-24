//
//  ATCClassicProfileViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 3/26/21.
//

import UIKit
import Firebase

let user = Auth.auth().currentUser
let userEmail = user?.email

class ATCClassicProfileViewController: UIViewController {
    
    let UserDataManager = FirebaseDataAccessManager()

    @IBOutlet weak var PersonIcon: UIImageView!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var ProfileBio: UILabel!
    @IBOutlet weak var Banner: UIImageView!
    
    @IBAction func ToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onReturn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func ToEdit(_ sender: Any) {
        let ProfileVC = ATCClassicEditProfileViewController(nibName: "ATCClassicEditProfileViewController", bundle: nil)
        navigationController?.pushViewController(ProfileVC, animated: true)
    }
    
    // This can make the profile icon a circle
    func makeRounded(ProfileImage: UIImageView) {
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.masksToBounds = false
        ProfileImage.layer.borderColor = UIColor.black.cgColor
 //This will change with corners of image and height/2 will make this circle shape
        ProfileImage.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDataManager.getUserInfo(uid: user!.uid) { (userData) in
            self.ProfileName.text = userData["UserName"]!
            if (userData["UserBio"] != "NULL") {
                self.ProfileBio.text = userData["UserBio"]!
            }
            if (userData["UserIconURL"] != "NULL") {
                let url = URL(string: userData["UserIconURL"]!)
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
                    guard let data = data, error == nil else {
                        print("Error trying to download user icon")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.PersonIcon.image = image
                        print("Should be Updated?")
                    }
                })
                task.resume()
            }
            if (userData["UserBannerURL"] != "NULL") {
                let url = URL(string: userData["UserBannerURL"]!)
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
                    guard let data = data, error == nil else {
                        print("Error trying to download user Banner")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.Banner.image = image
                        print("Should be Updated?")
                    }
                })
                task.resume()
            }
        }
        makeRounded(ProfileImage: PersonIcon)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDataManager.getUserInfo(uid: user!.uid) { (userData) in
            self.ProfileName.text = userData["UserName"]!
            if (userData["UserBio"] != "NULL") {
                self.ProfileBio.text = userData["UserBio"]!
            }
            if (userData["UserIconURL"] != "NULL") {
                let url = URL(string: userData["UserIconURL"]!)
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
                    guard let data = data, error == nil else {
                        print("Error trying to download user icon")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.PersonIcon.image = image
                    }
                })
                task.resume()
            }
            if (userData["UserBannerURL"] != "NULL") {
                let url = URL(string: userData["UserBannerURL"]!)
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
                    guard let data = data, error == nil else {
                        print("Error trying to download user Banner")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.Banner.image = image
                    }
                })
                task.resume()
            }
        }
        makeRounded(ProfileImage: PersonIcon)
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
