//
//  DataModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

struct DataModel: Decodable {
    let blocks: [Block]
    let order: [BlockType]
    
    var allBlocks: [Block] {
        order.flatMap { blocksOf(blockType: $0) }
    }
        
    private enum CodingKeys: String, CodingKey {
        case blocks = "data"
        case order = "view"
    }
    
    // MARK: - Private methods
    
    private func blocksOf(blockType: BlockType) -> [Block] {
        blocks.filter { $0.type == blockType }
    }
}
