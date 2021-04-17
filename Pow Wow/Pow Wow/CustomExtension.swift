//
//  CustomExtension.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 4/16/21.
//

import Foundation

public extension UITextField {
    func configure(color: UIColor, font: UIFont, cornerRadius: CGFloat, borderColor: UIColor, backgroundColor: UIColor, borderWidth: CGFloat) {
        self.textColor = color
        self.font = font
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        let paddingView = UIView(frame: .init(origin: .zero, size: .init(width: borderWidth, height: frame.height)))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
