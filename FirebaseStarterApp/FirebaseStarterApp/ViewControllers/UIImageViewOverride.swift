//
//  UIImageViewOverride.swift
//  FirebaseStarterApp
//
//  Created by 刘淳傲 on 4/19/21.
//  Copyright © 2021 Instamobile. All rights reserved.
//

import UIKit

class UIImageViewOverride: UIImageView {
    
    override func layoutSubviews() {
            super.layoutSubviews()

            let radius: CGFloat = (self.bounds.size.width / 2.0) - 3

            self.layer.cornerRadius = radius
        }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
