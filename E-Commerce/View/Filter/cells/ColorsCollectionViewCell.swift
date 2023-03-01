//
//  ColorsCollectionViewCell.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 3/1/23.
//

import UIKit

class ColorsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView! {
        didSet {
            colorView.layer.cornerRadius = colorView.frame.width / 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
