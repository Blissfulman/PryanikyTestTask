//
//  Block.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 12.03.2021.
//

import Foundation

struct Block: Decodable {
    let type: BlockType?
    let data: BlockData?
    
    private enum CodingKeys: String, CodingKey {
        case type = "name"
        case data
    }
    
    // MARK: - Initializers
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let blockType = try values.decode(BlockType.self, forKey: .type)
        self.type = blockType

        switch blockType {
        case .text:
            let data = try values.decode(TextBlockData.self, forKey: .data)
            self.data = .text(text: data.text)
        case .picture:
            let data = try values.decode(PictureBlockData.self, forKey: .data)
            self.data = .picture(text: data.text, url: data.url)
        case .selector:
            let data = try values.decode(SelectorBlockData.self, forKey: .data)
            self.data = .selector(selectedID: data.selectedID, variants: data.variants)
        case .other:
            self.data = nil
        }
    }
    
    // MARK: - Nested types
    
    struct TextBlockData: Decodable {
        let text: String?
    }
    
    struct PictureBlockData: Decodable {
        let text: String?
        let url: URL?
    }
    
    struct SelectorBlockData: Decodable {
        let selectedID: Int?
        let variants: [SelectorBlockDataVariant]

        private enum CodingKeys: String, CodingKey {
            case selectedID = "selectedId"
            case variants
        }
    }
}
