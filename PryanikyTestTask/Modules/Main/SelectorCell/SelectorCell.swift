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
        buttons.forEach { stackView.removeArrangedSubview($0) }
        buttons = []
    }
    
    // MARK: - Public methods
    
    func configure() {
        setupViewModelBindings()
        viewModel.initialSetupVariants()
    }
    
    // MARK: - Private methods
    
    private func setupViewModelBindings() {
        guard viewModel != nil else { return }
        
        viewModel.needSetupVariants = { [weak self] titles, selectedID in
            self?.buttons = titles.enumerated().map {
                let button = UIButton()
                button.setTitle($0.element, for: .normal)
                button.isUserInteractionEnabled = true
                button.translatesAutoresizingMaskIntoConstraints = false
                
                let buttonTapGR = UITapGestureRecognizer(target: self, action: #selector(self?.buttonDidTap))
                button.addGestureRecognizer(buttonTapGR)
                return button
            }
            self?.addButtonsToStackView()
        }
        
        viewModel.needSetupSelection = { [weak self] id in
            self?.buttons.forEach { $0.backgroundColor = .systemGray }
            self?.buttons[id].backgroundColor = .systemBlue
        }
    }
    
    @objc private func buttonDidTap(sender: UITapGestureRecognizer) {
        if let button = sender.view as? UIButton {
            if let buttonID = buttons.firstIndex(where: { $0 == button }) {
                viewModel.variantDidSelect(atIndex: buttonID)
            }
        }
    }
    
    private func addButtonsToStackView() {
        buttons.forEach { stackView.addArrangedSubview($0) }
    }
}
