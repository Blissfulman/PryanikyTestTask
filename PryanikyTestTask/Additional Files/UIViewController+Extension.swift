//
//  UIViewController+Extension.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit

extension UIViewController {
    
    func showActionDescription(type: BlockType, message: String) {
        let alert = UIAlertController(title: type.typeName, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
