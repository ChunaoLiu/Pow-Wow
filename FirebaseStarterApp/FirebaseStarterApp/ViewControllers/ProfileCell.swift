//
//  ProfileCell.swift
//  FirebaseStarterApp
//
//  Created by J6 on 4/25/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import UIKit

// Profile Cell Class used for Individual Profile Cell Objects

class ProfileCell: UITableViewCell {
    // Initialize UI References
    @IBOutlet weak var profileImageView: UIImageView! // Profile Picture (as UIImage)
    @IBOutlet weak var profileNameLabel: UILabel! // Consultant or Business Name (as String)
    @IBOutlet weak var profileTypeLabel: UILabel! // Type (Consultant or Business) (as String)
    @IBOutlet weak var profileDescriptionLabel: UILabel! // Description (as String)
    @IBOutlet weak var profileKeywordsLabel: UILabel! // Keywords (as String)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setProfile(profile: Pro) { // Maps Data from Pro Object to Profile Cell UI
        profileImageView.image = profile.image
        profileNameLabel.text = profile.name
        profileTypeLabel.text = profile.type
        profileDescriptionLabel.text = profile.description
        profileKeywordsLabel.text = profile.keywords
    }
}
