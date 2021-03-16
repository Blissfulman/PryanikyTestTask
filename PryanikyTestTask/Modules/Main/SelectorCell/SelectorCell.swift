//
//  SelectorCell.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import UIKit

final class SelectorCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: - Properties
    
    var viewModel: SelectorCellViewModelProtocol!
    
    private var buttons = [UIButton]()
    
    // MARK: - Lifecycle methods
    
    override func prepareForReuse() {
        buttons.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Public methods
    
    func configure() {
        selectionStyle = .none
        setupViewModelBindings()
        viewModel.initialSetupOfVariants()
    }
    
    // MARK: - Private methods
    
    private func setupViewModelBindings() {
        guard viewModel != nil else { return }
        
        viewModel.needSetupVariants = { [weak self] titles in
            self?.buttons = titles.map {
                let buttonTapGR = UITapGestureRecognizer(target: self, action: #selector(self?.buttonDidTap))
                let button = UIButton.buttonOfVariant(withTitle: $0)
                button.addGestureRecognizer(buttonTapGR)
                return button
            }
            self?.addButtonsToStackView()
        }
        
        viewModel.needSetupSelection = { [weak self] id in
            guard let self = self else { return }
            
            self.buttons.forEach { $0.backgroundColor = UIConstants.buttonDeselectedColor }
            if let button = self.buttons[safeIndex: id] {
                button.backgroundColor = UIConstants.buttonSelectedColor
            }
        }
    }
    
    @objc private func buttonDidTap(sender: UITapGestureRecognizer) {
        if let button = sender.view as? UIButton {
            if let index = buttons.firstIndex(where: { $0 == button }) {
                viewModel.variantDidSelect(atIndex: index)
            }
        }
    }
    
    private func addButtonsToStackView() {
        buttons.forEach { stackView.addArrangedSubview($0) }
    }
}
