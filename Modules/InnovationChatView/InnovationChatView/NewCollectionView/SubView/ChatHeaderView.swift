//
//  ChatHeaderView..swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

struct ChatHeaderView: View {
    var body: some View {
        let _ = Self._printChanges()
        HStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .overlay {
                    Text("프로필")
                }
            
            Rectangle()
                .fill(.white)
                .overlay {
                    Text("채팅")
                }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ChatHeaderView()
}
