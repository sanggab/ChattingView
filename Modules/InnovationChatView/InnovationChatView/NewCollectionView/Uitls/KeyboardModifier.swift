//
//  KeyboardModifier.swift
//  InnovationChatView
//
//  Created by Gab on 3/23/25.
//

import SwiftUI

import Combine

struct KeyboardOption: Hashable {
    let size: CGSize
    let curve: Int
    let duration: TimeInterval
    
    init(size: CGSize, curve: Int, duration: TimeInterval) {
        self.size = size
        self.curve = curve
        self.duration = duration
    }
}

extension KeyboardOption {
    func makingCurveAnimation() -> Animation {
        let uikitCurve: UIView.AnimationCurve! = .init(rawValue: curve)
        
        let timing = UICubicTimingParameters(animationCurve: uikitCurve)
        
        let curveAnimation: Animation = .timingCurve(Double(timing.controlPoint1.x),
                                             Double(timing.controlPoint1.x),
                                             Double(timing.controlPoint1.x),
                                             Double(timing.controlPoint1.x),
                                             duration: duration)
        
        return curveAnimation
    }
}

enum KeyboardState: Hashable {
    case willShow
    case willHide
    
    case didShow
    case didHide
}

struct KeyboardModifier: ViewModifier {
    private let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap(\.userInfo)
    
    private let keyboardDidShow = NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)
        .compactMap(\.userInfo)
    
    private let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        .compactMap(\.userInfo)
    
    private let keyboardDidHide = NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)
        .compactMap(\.userInfo)
    
    let willShow: ((KeyboardOption) -> Void)?
    let willHide: ((KeyboardOption) -> Void)?
    let didShow: ((KeyboardOption) -> Void)?
    let didHide: ((KeyboardOption) -> Void)?
    
    init(willShow: ((KeyboardOption) -> Void)? = nil,
         willHide: ((KeyboardOption) -> Void)? = nil,
         didShow: ((KeyboardOption) -> Void)? = nil,
         didHide: ((KeyboardOption) -> Void)? = nil) {
        self.willShow = willShow
        self.willHide = willHide
        self.didShow = didShow
        self.didHide = didHide
    }
    
    func body(content: Content) -> some View {
        content
            .onReceive(keyboardWillShow) { userInfo in
                let size: CGSize = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect)?.size ?? .zero
                let curve: Int = (userInfo["UIKeyboardAnimationCurveUserInfoKey"] as? Int) ?? .zero
                let duration: TimeInterval = (userInfo["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval) ?? .zero
                
                let keyboardOption: KeyboardOption = self.makeKeyboardOption(size: size, curve: curve, duration: duration)
                
                self.willShow?(keyboardOption)
            }
            .onReceive(keyboardDidShow) { userInfo in
                let size: CGSize = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect)?.size ?? .zero
                let curve: Int = (userInfo["UIKeyboardAnimationCurveUserInfoKey"] as? Int) ?? .zero
                let duration: TimeInterval = (userInfo["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval) ?? .zero
                
                let keyboardOption: KeyboardOption = self.makeKeyboardOption(size: size, curve: curve, duration: duration)
                
                self.didShow?(keyboardOption)
            }
            .onReceive(keyboardWillHide) { userInfo in
                let size: CGSize = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect)?.size ?? .zero
                let newSize: CGSize = .init(width: size.width, height: .zero)
                
                let curve: Int = (userInfo["UIKeyboardAnimationCurveUserInfoKey"] as? Int) ?? .zero
                let duration: TimeInterval = (userInfo["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval) ?? .zero
                
                let keyboardOption: KeyboardOption = self.makeKeyboardOption(size: newSize, curve: curve, duration: duration)
                
                self.willHide?(keyboardOption)
            }
            .onReceive(keyboardDidHide) { userInfo in
                let size: CGSize = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect)?.size ?? .zero
                let newSize: CGSize = .init(width: size.width, height: .zero)
                
                let curve: Int = (userInfo["UIKeyboardAnimationCurveUserInfoKey"] as? Int) ?? .zero
                let duration: TimeInterval = (userInfo["UIKeyboardAnimationDurationUserInfoKey"] as? TimeInterval) ?? .zero
                
                let keyboardOption: KeyboardOption = self.makeKeyboardOption(size: newSize, curve: curve, duration: duration)
                
                self.didHide?(keyboardOption)
            }
    }
    
    
    private func makeKeyboardOption(size keyboardSize: CGSize,
                                    curve animationCurve: Int,
                                    duration keyboardAnimationDuration: TimeInterval) -> KeyboardOption {
        return KeyboardOption(size: keyboardSize,
                              curve: animationCurve,
                              duration: keyboardAnimationDuration)
    }
}

extension View {
    func keyboardWillShow(willShow: ((KeyboardOption) -> Void)? = nil) -> some View {
        modifier(KeyboardModifier(willShow: willShow))
    }
    
    func keyboardWillHide(willHide: ((KeyboardOption) -> Void)? = nil) -> some View {
        modifier(KeyboardModifier(willHide: willHide))
    }
    
    func keyboardDidShow(didShow: ((KeyboardOption) -> Void)? = nil) -> some View {
        modifier(KeyboardModifier(didShow: didShow))
    }
    
    func keyboardDidHide(didHide: ((KeyboardOption) -> Void)? = nil) -> some View {
        modifier(KeyboardModifier(didHide: didHide))
    }
}
