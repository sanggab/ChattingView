//
//  KeyboardModifier.swift
//  ChattingView
//
//  Created by 심상갑 on 3/8/25.
//

import SwiftUI
import Combine

struct KeyboardModifier: ViewModifier {
    
    private let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { notification in
            notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
        }
        .map(\.height)
    
    private let keyboardWillShow2 = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap(\.userInfo)
    
    private let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        .map({ _ in CGFloat(0) })
    
    private let keyboardWillHide2 = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        .compactMap(\.userInfo)
    
    private let keyboardDuration = NotificationCenter.default.publisher(for: Notification.Name(rawValue: UIResponder.keyboardAnimationDurationUserInfoKey))
        .compactMap { notification in
            
        }
    
    @State private var offset: CGFloat = 0
    
    
    func body(content: Content) -> some View {
        content
            .onReceive(Publishers.Merge(keyboardWillShow2, keyboardWillHide2)) { output in
                let height: CGFloat = (output["UIKeyboardFrameEndUserInfoKey"] as? CGRect)?.height ?? .zero
                let duration: TimeInterval = (output["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval) ?? .zero
                let curve: Int = (output["UIKeyboardAnimationCurveUserInfoKey"] as? Int) ?? .zero
                
                print("\(#function) height: \(height)")
                print("\(#function) duration: \(duration)")
                print("\(#function) curve: \(curve)")
                
                let uikitCurve: UIView.AnimationCurve! = .init(rawValue: curve)
                
                let timing = UICubicTimingParameters(animationCurve: uikitCurve)
                
                let curveAnimation: Animation = .timingCurve(Double(timing.controlPoint1.x),
                                                     Double(timing.controlPoint1.x),
                                                     Double(timing.controlPoint1.x),
                                                     Double(timing.controlPoint1.x),
                                                     duration: duration)
                
                withAnimation(curveAnimation) {
                    offset = height
                }
            }
//            .onReceive(Publishers.Merge(keyboardWillShow, keyboardWillHide)) { output in
//                print("\(#function) : \(output)")
//                withAnimation(.easeInOut(duration: 0.1)) {
//                    offset = output
//                }
//            }
            .padding(.bottom, offset)
    }
}
