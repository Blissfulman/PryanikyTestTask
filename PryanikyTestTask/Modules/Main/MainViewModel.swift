//
//  MainViewModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Foundation

// MARK: - Protocols

protocol MainViewModelProtocol {
    var dataDidUpdate: (() -> Void)? { get set }
    var numberOfRows: Int { get }
    
    func getBlockDataForRow(at indexPath: IndexPath) -> BlockData?
    func getBlockDescription(at indexPath: IndexPath) -> (type: BlockType, message: String)?
}

final class MainViewModel: MainViewModelProtocol {
    
    // MARK: - Properties
    
    var dataDidUpdate: (() -> Void)?
    
    var numberOfRows: Int {
        blocks.count
    }
    
    private var blocks = [Block]() {
        didSet {
            dataDidUpdate?()
        }
    }
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    
    // MARK: - Initializers
    
    init() {
        getData()
    }
    
    // MARK: - Public methods
    
    func getBlockDataForRow(at indexPath: IndexPath) -> BlockData? {
        blocks[safeIndex: indexPath.row]?.data
    }
    
    func getBlockDescription(at indexPath: IndexPath) -> (type: BlockType, message: String)? {
        guard let blockData = getBlockDataForRow(at: indexPath) else { return nil }
        
        switch blockData {
        case let .text(text):
            return (type: .text, message: "Текст: \"\(text ?? "")\"")
        case let .picture(text, _):
            return (type: .picture, message: "Картинка с подписью \"\(text ?? "")\"")
        case .selector:
            return nil
        }
    }
    
    // MARK: - Private methods
    
    private func getData() {
        networkService.fetchDataWithCombine { [weak self] result in
            switch result {
            case .success(let dataModel):
                self?.blocks = dataModel.allBlocks
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
