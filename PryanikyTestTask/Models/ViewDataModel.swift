//
//  ViewDataModel.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

struct ViewDataModel: Decodable {
    let blocks: [Block]
    let order: [BlockType]
    
    private enum CodingKeys: String, CodingKey {
        case blocks = "data"
        case order = "view"
    }
}

struct Block: Decodable {
    let type: BlockType
    let data: BlockData
    
    private enum CodingKeys: String, CodingKey {
        case type = "name"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let blockType = try values.decode(BlockType.self, forKey: .type)
        self.type = blockType

        switch blockType {
        case .text:
            let data = try values.decode(TextBlockData.self, forKey: .data)
            self.data = .text(data: data)
        case .picture:
            let data = try values.decode(PictureBlockData.self, forKey: .data)
            self.data = .picture(data: data)
        case .selector:
            let data = try values.decode(SelectorBlockData.self, forKey: .data)
            self.data = .selector(data: data)
        }
    }
}

enum BlockData {
    case text(data: TextBlockData)
    case picture(data: PictureBlockData)
    case selector(data: SelectorBlockData)
}

enum BlockType: String, Decodable {
    case text
    case picture
    case selector
    
    private enum CodingKeys: String, CodingKey {
        case text
        case picture
        case selector
    }
    
    init(from decoder: Decoder) throws {
        let type = try decoder.singleValueContainer().decode(String.self)
        switch type {
        case "hz":
            self = .text
        case "picture":
            self = .picture
        case "selector":
            self = .selector
        default: self = .text
        }
    }
}
