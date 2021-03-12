//
//  PictureCell.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit
import Kingfisher

final class PictureCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var pictureImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Public methods
    
    func configure(text: String?, url: URL?) {
        pictureImageView.kf.indicatorType = .activity
        pictureImageView.kf.setImage(with: url)
        titleLabel.text = text
    }
}
