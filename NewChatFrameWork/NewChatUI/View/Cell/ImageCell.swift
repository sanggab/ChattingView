//
//  ImageCell.swift
//  NewChatUI
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Kingfisher

public struct NewImageCell: View {
    public var urlString: String?
    
    public init(urlString: String? = nil) {
        self.urlString = urlString
    }
    
    public var body: some View {
        KFImage(URL(string: urlString ?? ""))
            .resizable()
            .frame(width: 300, height: 300)
    }
}
