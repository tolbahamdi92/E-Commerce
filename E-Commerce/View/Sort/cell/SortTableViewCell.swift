//
//  SortTableViewCell.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/28/23.
//

import UIKit

class SortTableViewCell: UITableViewCell {

    @IBOutlet weak var sortedNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
