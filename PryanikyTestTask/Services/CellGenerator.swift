//
//  CellGenerator.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit

final class CellGenerator {
    
    func getCellAtBlockData(_ blockData: BlockData,
                            withIndexPath indexPath: IndexPath,
                            forTableView tableView: UITableView,
                            delegate: UIViewController) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch blockData {
        case let .text(text):
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier,
                                                               for: indexPath) as? TextCell else { break }
            textCell.textLabel?.text = text
            cell = textCell
        case let .picture(text, url):
            guard let pictureCell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier,
                                                                  for: indexPath) as? PictureCell else { break }
            pictureCell.configure(text: text, url: url)
            cell = pictureCell
        case let .selector(selectedID, variants):
            guard let selectorCell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.identifier,
                                                                   for: indexPath) as? SelectorCell else { break }
            selectorCell.viewModel = SelectorCellViewModel(selectedID: selectedID, variants: variants)
            guard let delegate = delegate as? SelectorCellViewModelDelegate else { break }
            selectorCell.viewModel.delegate = delegate
            selectorCell.configure()
            cell = selectorCell
        }
        
        return cell
    }
}
