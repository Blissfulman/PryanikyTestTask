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
    
    // MARK: - Properties
    
    var typeName: String {
        switch self {
        case .text:
            return "Блок с текстом"
        case .picture:
            return "Блок с картинкой"
        case .selector:
            return "Блок с вариантами"
        case .other:
            return "Что-то пошло не так..."
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case text
        case picture
        case selector
    }
    
    // MARK: - Initializers
    
    init(from decoder: Decoder) throws {
        let type = try decoder.singleValueContainer().decode(String.self)
        self = BlockType(rawValue: type) ?? .other
    }
}
