//
//  Model.swift
//  NewChatModel
//
//  Created by Gab on 3/31/25.
//

import UIKit

public enum NewChattingState: Equatable {
    /// 최초 세팅 시
    case onAppear
    /// 작업 대기중
    case waiting
    /// 키보드 상태변화
    case keyboard
    /// 채팅입력 상태
    case textInput
    /// Cell 재구성
    case reconfigure
    /// 재로드
    case reload
    /// 새로고침
    case refresh
    
    case test
}
