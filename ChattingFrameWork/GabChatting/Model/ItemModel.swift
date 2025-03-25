//
//  ItemModel.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

struct DummyItemModel: Hashable, Identifiable {
    typealias ID = String
    
    var id: ID = UUID().uuidString
    
    init() { }
}
