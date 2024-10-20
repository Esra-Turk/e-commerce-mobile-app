//
//  AnimationHelper.swift
//  e-commerce-app
//
//  Created by Esra Türk on 20.10.2024.
//

import Foundation
import UIKit
import Lottie

class AnimationHelper {

    static let shared = AnimationHelper()
    private var animationView = LottieAnimationView()
    private var blurEffectView: UIVisualEffectView?
    
    private init() {}

    func setupAnimation(on view: UIView, animationName: String) {
        animationView.removeFromSuperview()
        blurEffectView?.removeFromSuperview()
        
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        
        if let blurEffectView = blurEffectView {
            view.addSubview(blurEffectView)
        }
        
        animationView = LottieAnimationView(name: animationName)
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play { [weak self] (finished) in
            if finished {
                self?.removeBlurEffect()
            }
        }
        
        view.addSubview(animationView)
    }

    private func removeBlurEffect() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blurEffectView?.alpha = 0
            self.animationView.alpha = 0
        }) { _ in
            self.blurEffectView?.removeFromSuperview()
            self.animationView.removeFromSuperview()
            self.blurEffectView = nil
        }
    }
}
