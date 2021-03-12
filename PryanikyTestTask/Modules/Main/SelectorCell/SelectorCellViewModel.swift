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
        
    private var selectedID: Int
    private let variants: [SelectorBlockDataVariant]
    
    private var selectedVariant: Int {
        get {
            selectedID - 1
        } set {
            selectedID = newValue + 1
        }
    }
    
    // MARK: - Initializers
    
    init(selectedID: Int?, variants: [SelectorBlockDataVariant]) {
        self.selectedID = selectedID ?? 0
        self.variants = variants
    }
    
    // MARK: - Public methods
    
    func initialSetupOfVariants() {
        needSetupVariants?(variants.compactMap { $0.text })
        needSetupSelection?(selectedVariant)
    }
    
    func variantDidSelect(atIndex index: Int) {
        selectedVariant = index
        needSetupSelection?(selectedVariant)
        let text = variants[safeIndex: selectedVariant]?.text ?? ""
        delegate?.showDescriprion(type: .selector, message: "Выбран вариант \"\(text)\"")
    }
}
