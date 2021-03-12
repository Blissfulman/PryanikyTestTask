//
//  MainViewModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Foundation

// MARK: - Protocols

protocol MainViewModelProtocol {
    var dataModel: Box<DataModel?> { get }
    var numberOfRows: Int { get }
    
    func blockDataForRow(at indexPath: IndexPath) -> BlockData?
}

final class MainViewModel: MainViewModelProtocol {
    
    var dataModel: Box<DataModel?> = Box(nil)
    
    var numberOfRows: Int {
        dataModel.value?.order.count ?? 0
    }
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    init() {
        getDataModel()
    }
    
    func blockDataForRow(at indexPath: IndexPath) -> BlockData? {
        guard let blockType = dataModel.value?.order[indexPath.row] else { return nil }
        return dataModel.value?.blocks.first(where: { $0.type == blockType })?.data
    }
    
    private func getDataModel() {
        networkService.fetchViewData { [weak self] result in
            switch result {
            case .success(let dataModel):
                self?.dataModel.value = dataModel
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
