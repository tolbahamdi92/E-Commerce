//
//  shadow+UIView.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit

extension UIView {
    func addShadow(cornerRadius: CGFloat = 10, shadowOffsetWidth: CGFloat = 2, shadowOffsetHeight: CGFloat = 3) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        //let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        //self.layer.shadowPath = shadowPath.cgPath
        //self.layer.borderWidth = 0.25
        //self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        
    }
}
