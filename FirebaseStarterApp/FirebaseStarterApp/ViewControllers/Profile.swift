//
//  Profile.swift
//  FirebaseStarterApp
//
//  Created by J6 on 4/25/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import Foundation
import UIKit

// Profile Class Contains Profile View Controller
// Individual Pro Objects Are Added To Table View


class Profile: UIViewController {
    var profiles: [Pro] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createArray() -> [Pro] {
        var tempProfiles: [Pro] = []
        
        let profileSampleOne: Pro(
            image: sample-image,
            name: "Sample Name",
            type: "Sample Type",
            description: "Sample Description",
            keywords: "Sample Keywords"
        )
        
        let profileSampleTwo: Pro(
            image: sample-image,
            name: "Sample Name",
            type: "Sample Type",
            description: "Sample Description",
            keywords: "Sample Keywords"
        )
        
        let profileSampleThree: Pro(
            image: sample-image,
            name: "Sample Name",
            type: "Sample Type",
            description: "Sample Description",
            keywords: "Sample Keywords"
        )
        
        tempProfiles.append(profileSampleOne)
        tempProfiles.append(profileSampleTwo)
        tempProfiles.append(profileSampleThree)
        
        return tempProfiles
    }
}
