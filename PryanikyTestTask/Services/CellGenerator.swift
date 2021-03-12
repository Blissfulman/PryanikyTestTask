//
//  CellGenerator.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit

final class CellGenerator {
    
    static func getCellAtBlockData(_ blockData: BlockData,
                                   withIndexPath indexPath: IndexPath,
                                   forTableView tableView: UITableView) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch blockData {
        case let .text(text):
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier,
                                                               for: indexPath) as? TextCell else { break }
            cell = textCell
            cell.textLabel?.text = text
        case let .picture(text, url):
            guard let pictureCell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier,
                                                                  for: indexPath) as? PictureCell else { break }
            cell = pictureCell
            cell.textLabel?.text = text
            if let url = url, let imageData = try? Data(contentsOf: url) {
                cell.imageView?.image = UIImage(data: imageData)
            }
        case let .selector(selectedID, variants):
            guard let selectorCell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.identifier,
                                                                   for: indexPath) as? SelectorCell else { break }
            cell = selectorCell
            let variantText = variants.first(where: { $0.id == selectedID })?.text
            cell.textLabel?.text = "ID: \(selectedID!) " + variantText!
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
