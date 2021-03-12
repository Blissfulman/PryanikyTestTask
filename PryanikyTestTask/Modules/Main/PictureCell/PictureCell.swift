//
//  PictureCell.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit

class PictureCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
