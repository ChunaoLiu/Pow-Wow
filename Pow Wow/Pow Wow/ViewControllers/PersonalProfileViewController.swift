//
//  PersonalProfileViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 3/26/21.
//

import UIKit

extension UIImage {

    static func imageByMergingImages(topImage: UIImage, bottomImage: UIImage, scaleForTop: CGFloat = 1.0) -> UIImage {
        let size = bottomImage.size
        let container = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        UIGraphicsGetCurrentContext()!.interpolationQuality = .high
        bottomImage.draw(in: container)

        let topWidth = size.width / scaleForTop
        let topHeight = size.height / scaleForTop
        let topX = (size.width / 2.0) - (topWidth / 2.0)
        let topY = (size.height / 2.0) - (topHeight / 2.0)

        topImage.draw(in: CGRect(x: topX, y: topY, width: topWidth, height: topHeight), blendMode: .normal, alpha: 1.0)

        return UIGraphicsGetImageFromCurrentImageContext()!
    }

}

class PersonalProfileViewController: UIViewController {

    @IBAction func ToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var PersonIcon: UIImageView!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var ProfileBio: UILabel!
    @IBOutlet weak var Banner: UIImageView!
    
    func make_Icon() {
        
        let Icon = UIImage(named: "person.fill")
        let IconImageView = UIImageView(image: Icon)
        IconImageView.frame = CGRect(x: Banner.center.x - 300, y: Banner.center.y - 150, width: 130, height: 130)
        makeRounded(ProfileImage: IconImageView)
        
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
