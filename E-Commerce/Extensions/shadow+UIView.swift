//
//  shadow+UIView.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10)
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowOpacity = 0.5
    }
}
