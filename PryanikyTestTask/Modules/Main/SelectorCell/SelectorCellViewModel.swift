//
//  SelectorCellViewModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import Foundation

// MARK: - Protocols

protocol SelectorCellViewModelProtocol {
    var needSetupVariants: (([String], Int) -> Void)? { get set }
    var needSetupSelection: ((Int) -> Void)? { get set }
    
    func initialSetupVariants()
    func variantDidSelect(atIndex index: Int)
}

final class SelectorCellViewModel: SelectorCellViewModelProtocol {
    
    // MARK: - Properties
    
    var needSetupVariants: (([String], Int) -> Void)?
    
    var needSetupSelection: ((Int) -> Void)?
        
    private var selectedID: Int
    
    private var selectedVariant: Int {
        get {
            selectedID - 1
        } set {
            selectedID = newValue + 1
        }
    }
    
    private let variants: [SelectorBlockDataVariant]
    
    // MARK: - Initializers
    
    init(selectedID: Int?, variants: [SelectorBlockDataVariant]) {
        self.selectedID = selectedID ?? 0
        self.variants = variants
    }
    
    // MARK: - Public methods
    
    func initialSetupVariants() {
        needSetupVariants?(variants.compactMap { $0.text }, selectedID)
        needSetupSelection?(selectedVariant)
    }
    
    func variantDidSelect(atIndex index: Int) {
        selectedVariant = index
        needSetupSelection?(selectedVariant)
    }
}
