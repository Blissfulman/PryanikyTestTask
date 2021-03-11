//
//  SelectorBlockData.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

struct SelectorBlockData: Decodable {
    let selectedID: Int?
    let variants: [SelectorBlockDataVariant]?

    private enum CodingKeys: String, CodingKey {
        case selectedID = "selectedId"
        case variants
    }
}

struct SelectorBlockDataVariant: Decodable {
    let id: Int?
    let text: String?
}
