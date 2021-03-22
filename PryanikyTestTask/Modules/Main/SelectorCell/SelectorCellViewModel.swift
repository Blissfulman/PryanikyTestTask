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
    /// Замыкание, в которое передаётся массив заголовков вариантов.
    var needSetupVariants: ((_ titles: [String]) -> Void)? { get set }
    /// Замыкание, в которое передаётся индекс выбранного варианта.
    var needSetupSelection: ((_ selectedIndex: Int) -> Void)? { get set }
    var delegate: SelectorCellViewModelDelegate! { get set }
    
    init(selectedID: Int?, variants: [SelectorBlockDataVariant])
    
    func initialSetupOfVariants()
    func variantDidSelect(atIndex index: Int)
}

final class SelectorCellViewModel: SelectorCellViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: SelectorCellViewModelDelegate!
    var needSetupVariants: ((_ titles: [String]) -> Void)?
    var needSetupSelection: ((_ selectedIndex: Int) -> Void)?
        
    private var selectedID: Int?
    private let variants: [SelectorBlockDataVariant]
    private var selectedIndex: Int? {
        variants.firstIndex { $0.id == selectedID }
    }
    
    // MARK: - Initializers
    
    init(selectedID: Int?, variants: [SelectorBlockDataVariant]) {
        self.selectedID = selectedID
        self.variants = variants
    }
    
    // MARK: - Public methods
    
    func initialSetupOfVariants() {
        needSetupVariants?(variants.compactMap { $0.text })
        if let selectedIndex = selectedIndex {
            needSetupSelection?(selectedIndex)
        }
    }
    
    func variantDidSelect(atIndex index: Int) {
        guard let selectedVariantID = variants[safeIndex: index]?.id else { return }
        selectedID = selectedVariantID
        
        if let selectedIndex = selectedIndex {
            needSetupSelection?(selectedIndex)
        }
        
        let text = variants.first(where: { $0.id == selectedID})?.text
        delegate?.showDescriprion(type: .selector, message: "Выбран вариант \"\(text ?? "")\"")
    }
}
