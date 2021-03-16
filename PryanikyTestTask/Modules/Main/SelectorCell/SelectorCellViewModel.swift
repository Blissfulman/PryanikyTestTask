//
//  SelectorCellViewModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import Foundation

// MARK: - Protocols

protocol SelectorCellViewModelDelegate: AnyObject {
    func showDescriprion(type: BlockType, message: String)
}

protocol SelectorCellViewModelProtocol {
    var needSetupVariants: (([String]) -> Void)? { get set }
    var needSetupSelection: ((Int) -> Void)? { get set }
    var delegate: SelectorCellViewModelDelegate! { get set }
    
    init(selectedID: Int?, variants: [SelectorBlockDataVariant])
    
    func initialSetupOfVariants()
    func variantDidSelect(atIndex index: Int)
}

final class SelectorCellViewModel: SelectorCellViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: SelectorCellViewModelDelegate!
    var needSetupVariants: (([String]) -> Void)?
    var needSetupSelection: ((Int) -> Void)?
        
    private var selectedID = 0
    private let variants: [SelectorBlockDataVariant]
    
    // MARK: - Initializers
    
    init(selectedID: Int?, variants: [SelectorBlockDataVariant]) {
        if let selectedID = selectedID {
            self.selectedID = selectedID - 1
        }
        self.variants = variants
    }
    
    // MARK: - Public methods
    
    func initialSetupOfVariants() {
        needSetupVariants?(variants.compactMap { $0.text })
        needSetupSelection?(selectedID)
    }
    
    func variantDidSelect(atIndex index: Int) {
        selectedID = index
        needSetupSelection?(selectedID)
        let text = variants[safeIndex: selectedID]?.text ?? ""
        delegate?.showDescriprion(type: .selector, message: "Выбран вариант \"\(text)\"")
    }
}
