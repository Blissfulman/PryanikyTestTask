//
//  MainViewModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Foundation

// MARK: - Protocols

protocol MainViewModelProtocol {
    var dataModelDidUpdate: (() -> Void)? { get set }
    var numberOfRows: Int { get }
    
    func blockDataForRow(at indexPath: IndexPath) -> BlockData?
}

final class MainViewModel: MainViewModelProtocol {
    
    // MARK: - Properties
    
    var dataModelDidUpdate: (() -> Void)?
    
    var numberOfRows: Int {
        dataModel?.order.count ?? 0
    }
    
    private var dataModel: DataModel? {
        didSet {
            dataModelDidUpdate?()
        }
    }
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    // MARK: - Initializers
    
    init() {
        getDataModel()
    }
    
    // MARK: - Public methods
    
    func blockDataForRow(at indexPath: IndexPath) -> BlockData? {
        guard let blockType = dataModel?.order[indexPath.row] else { return nil }

        return dataModel?.blocks.first(where: { $0.type == blockType })?.data
    }
    
    // MARK: - Private methods
    
    private func getDataModel() {
        networkService.fetchViewData { [weak self] result in
            switch result {
            case .success(let dataModel):
                self?.dataModel = dataModel
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
