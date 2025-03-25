//
//  SizeUtils.swift
//  ChattingUtils
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

public extension View {
    func getSize(_ size: @escaping ((CGSize) -> Void)) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear
                    .frame(width: 0, height: 0)
                    .onAppear {
                        size(proxy.size)
                    }
            }
        }
    }
}
