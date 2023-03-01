//
//  DetailCategoryCollectionViewCell.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/27/23.
//

import UIKit

class DetailCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!{
        didSet {
            containerView.addShadow(cornerRadius: 10, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    
    @IBOutlet weak var productImageView: UIImageView!{
        didSet {
            productImageView.layer.cornerRadius = 10
            productImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    
    @IBOutlet weak var containerStackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
