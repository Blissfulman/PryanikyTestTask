//
//  ViewDataModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

struct ViewDataModel: Decodable {
    let blocks: [Block]?
    let types: [BlockType]?
    
    private enum CodingKeys: String, CodingKey {
        case blocks = "data"
        case types = "view"
    }
}

struct Block: Decodable {
    let type: BlockType?
    let data: BlockData?
    
    private enum CodingKeys: String, CodingKey {
        case type = "name"
        case data
    }
}

enum BlockData: Decodable {
    case text(data: TextBlockData)
    case picture(data: PictureBlockData)
    case selector(data: SelectorBlockData)
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let blockType = try values.decode(BlockType.self, forKey: .name)
        
        switch blockType {
        case .text:
            let data = try values.decode(TextBlockData.self, forKey: .data)
            self = .text(data: data)
        case .picture:
            let data = try values.decode(PictureBlockData.self, forKey: .data)
            self = .picture(data: data)
        case .selector:
            let data = try values.decode(SelectorBlockData.self, forKey: .data)
            self = .selector(data: data)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case data
    }
}

enum BlockType: String, Decodable {
    case text
    case picture
    case selector
    
    private enum CodingKeys: String, CodingKey {
        case text = "hz"
        case picture
        case selector
    }
}
