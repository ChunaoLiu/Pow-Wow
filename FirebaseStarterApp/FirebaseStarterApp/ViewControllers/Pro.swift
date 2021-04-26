//
//  Pro.swift
//  FirebaseStarterApp
//
//  Created by J6 on 4/25/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import Foundation
import UIKit

// Pro Class Contains Individual Profile Objects
// Including:
// Profile >> Image (UIImage)
// Profile >> Name (String)
// Profile >> Type (String)
// Profile >> Description (String)
// Profile >> Keywords (String)

class Pro {
    // Initialize Pro Variables
    var image: UIImage
    var name: String
    var type: String
    var description: String
    var keywords: String
    
    // Pro Constructor
    init(image: UIImage, name: String, type: String, description: String, keywords: String) {
        self.image = image
        self.name = name
        self.type = type
        self.description = description
        self.keywords = keywords
    }
}
