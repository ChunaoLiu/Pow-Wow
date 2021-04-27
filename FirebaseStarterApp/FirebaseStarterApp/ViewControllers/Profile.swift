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
    
    let FirebaseDataManager = FirebaseDataAccessManager()
    
    @IBOutlet weak var tableView: UITableView! // Main table view on view controller
    
    override func viewDidLoad() { // Main Constructor
        super.viewDidLoad() // Super Constructor
        
        createArray() // Calls createArray() function to update profiles array
        
        // tableView.delegate = self // Setting view controller delegate of tableView
        // tableView.dataSource = self // Setting view controller dataSource of tableView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createArray()
    }

    
    func createArray() {
        var tempProfiles: [Pro] = [] // Array of Pro objects used to return profiles to tableView
        
        // I'll place system image for now to test how it looks
        
        FirebaseDataManager.getAllUser { (ProList) in
            tempProfiles = ProList
            self.profiles = tempProfiles
            print("Count in function is: " + String(self.profiles.count))
            self.tableView.reloadData()
        }
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
