//
//  CollectionView + Animation.swift
//  NewChatUI
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

extension ChattingView {
    /// setContentOffset 애니메이션 기능
    func executeSetContentOffset(_ uiView: UICollectionView, offset: CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: .now() + self.keyboardOption.duration) {
            uiView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
            uiView.layoutIfNeeded()
        }
    }
    /// UIViewPropertyAnimator 기능
    func executeAnimator(_ uiView: UICollectionView, offsetY: CGFloat) {
        let curve = UIView.AnimationCurve(rawValue: self.keyboardOption.curve)!
        let animtor = UIViewPropertyAnimator(duration: self.keyboardOption.duration, curve: curve)
        
        animtor.addAnimations {
            uiView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
            
            uiView.layoutIfNeeded()
        }
        
        animtor.startAnimation()
    }
}
