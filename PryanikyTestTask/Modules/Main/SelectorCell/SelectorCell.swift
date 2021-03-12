//
//  SelectorCell.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit

final class SelectorCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public methods
    
    func configure(selectedID: Int?, variants: [SelectorBlockDataVariant]) {
        let variantText = variants.first(where: { $0.id == selectedID })?.text
        textLabel?.text = "ID: \(selectedID!) " + variantText!
    }
}
