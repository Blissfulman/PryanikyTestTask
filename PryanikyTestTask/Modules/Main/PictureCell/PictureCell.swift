//
//  PictureCell.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit

final class PictureCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var pictureImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        backgroundColor = .yellow
        // Configure the view for the selected state
    }
    
    // MARK: - Public methods
    
    func configure(text: String?, url: URL?) {
        if let url = url, let imageData = try? Data(contentsOf: url) {
            pictureImageView.image = UIImage(data: imageData)
        }
        titleLabel.text = text
    }
}
