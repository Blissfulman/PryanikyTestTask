//
//  TextCell.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit

final class TextCell: UITableViewCell {
    
    // MARK: - Lifecycle methods
    
    override func prepareForReuse() {
        textLabel?.text = nil
    }
}
