//
//  BlockType.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

enum BlockType: String, Decodable {
    case text = "hz"
    case picture
    case selector
    case other
    
    private enum CodingKeys: String, CodingKey {
        case text
        case picture
        case selector
    }
    
    init(from decoder: Decoder) throws {
        let type = try decoder.singleValueContainer().decode(String.self)
        self = BlockType(rawValue: type) ?? .other
    }
}
