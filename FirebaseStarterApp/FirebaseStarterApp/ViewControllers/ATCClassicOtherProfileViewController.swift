//
//  ATCClassicOtherProfileViewController.swift
//  FirebaseStarterApp
//
//  Created by 刘淳傲 on 4/27/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import UIKit
import Foundation

class ATCClassicOtherProfileViewController: UIViewController {

    @IBOutlet weak var UserBanner: UIImageView!
    @IBOutlet weak var UserIcon: UIImageViewOverride!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserType: UISegmentedControl!
    @IBOutlet weak var UserBio: UILabel!
    @IBOutlet weak var UserKeyword: UILabel!
    
    var BannerImage: UIImage = UIImage(systemName: "paperplane.fill")!
    var IconImage: UIImage = UIImage(systemName: "paperplane.fill")!
    var UName: String = ""
    var UType: String = ""
    var UBio: String = ""
    var UKeywords: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func onReturn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.UserBanner.image = BannerImage
        self.UserIcon.image = IconImage
        self.UserName.text = UName
        if (self.UType == "Consultant") {
            self.UserType.selectedSegmentIndex = 0
        } else {
            self.UserType.selectedSegmentIndex = 1
        }
        self.UserBio.text = UBio
        self.UserKeyword.text = "Keyword: " + UKeywords

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
