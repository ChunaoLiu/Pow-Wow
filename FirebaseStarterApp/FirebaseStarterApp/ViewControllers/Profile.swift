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
    var profiles: [Pro] = [] // All the profiles rendered to tableView
    
    @IBOutlet weak var tableView: UITableView! // Main table view on view controller
    
    override func viewDidLoad() { // Main Constructor
        super.viewDidLoad() // Super Constructor
        
        profiles = createArray() // Calls createArray() function to update profiles array
        
        // tableView.delegate = self // Setting view controller delegate of tableView
        // tableView.dataSource = self // Setting view controller dataSource of tableView
    }
    
    func createArray() -> [Pro] {
        var tempProfiles: [Pro] = [] // Array of Pro objects used to return profiles to tableView
        
        // I'll place system image for now to test how it looks
        
        let profileSampleOne = Pro( // Placeholder Pro object
            image: UIImage(systemName: "info.circle")!,
            name: "Sample Name",
            type: "Sample Type",
            description: "Sample Description",
            keywords: "Sample Keywords"
        )
        
        let profileSampleTwo = Pro( // Placeholder Pro object
            image: UIImage(systemName: "info.circle")!,
            name: "Sample Name",
            type: "Sample Type",
            description: "Sample Description",
            keywords: "Sample Keywords"
        )
        
        let profileSampleThree = Pro( // Placeholder Pro object
            image: UIImage(systemName: "info.circle")!,
            name: "Sample Name",
            type: "Sample Type",
            description: "Sample Description",
            keywords: "Sample Keywords"
        )
        
        tempProfiles.append(profileSampleOne) // Placeholder append to tempProfiles array
        tempProfiles.append(profileSampleTwo) // Placeholder append to tempProfiles array
        tempProfiles.append(profileSampleThree) // Placeholder append to tempProfiles array
        
        return tempProfiles // This array will contain the Pro objects displayed on tableView
    }
}

extension Profile: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Allocates space
        return profiles.count // Returns number of profiles in tableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profile = profiles[indexPath.row] // Current profile set to index indexPath.row of profiles array
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        
        cell.setProfile(profile: profile) // Current profile set to current cell
        
        return cell // Returns current profile cell
    }
}
