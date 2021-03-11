//
//  DataModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

struct DataModel: Decodable {
    let blocks: [Block]
    let order: [BlockType]
    
    private enum CodingKeys: String, CodingKey {
        case blocks = "data"
        case order = "view"
    }
}
