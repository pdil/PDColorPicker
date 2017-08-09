//
//  ViewProtocols.swift
//  FoodEase
//
//  Created by Paolo Di Lorenzo on 4/5/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

////
protocol Fadeable {  }

extension Fadeable where Self: UIView {
  func appear() {
    UIView.animate(withDuration: 0.25) {
      self.alpha = 1
    }
  }

  func disappear() {
    UIView.animate(withDuration: 0.25) {
      self.alpha = 0
    }
  }
}

////
protocol Shakeable { }

extension Shakeable where Self: UIView {

  func shake(withDuration duration: CFTimeInterval, oscillations: Float, offset: CGFloat, completion: (() -> Void)? = nil) {
    CATransaction.begin()
    let animation = CABasicAnimation(keyPath: "position")

    animation.duration = duration
    animation.repeatCount = oscillations
    animation.autoreverses = true

    animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - offset, y: center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + offset, y: center.y))

    CATransaction.setCompletionBlock(completion)

    layer.add(animation, forKey: "position")
    CATransaction.commit()
  }
  
}
