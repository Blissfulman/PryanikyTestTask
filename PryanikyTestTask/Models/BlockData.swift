//
//  BlockData.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Foundation

enum BlockData {
    case text(text: String?)
    case picture(text: String?, url: URL?)
    case selector(selectedID: Int?, variants: [SelectorBlockDataVariant])
}
