//
//  SubCategoriesCollectionViewCell.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/27/23.
//

import UIKit

class SubCategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var subCategoryView: UIView! {
        didSet {
            self.subCategoryView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var subCategoryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
