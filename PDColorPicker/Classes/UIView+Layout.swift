//
//  UIView+Layout.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/8/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
extension UIView {

  /// Provides a convenient method for anchoring the view to other
  /// anchors within its view hierarchy. All parameters have default values of
  /// `nil` or `0` so only the desired constraints need be provided.
  ///
  /// This method should only be called *after* the view has been added to its superview.
  ///
  /// This method sets `translatesAutoresizingMaskIntoConstraints` to `false` on
  /// the view.
  func anchor(left: NSLayoutXAxisAnchor? = nil,
              right: NSLayoutXAxisAnchor? = nil,
              top: NSLayoutYAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              leftConstant: CGFloat = 0,
              rightConstant: CGFloat = 0,
              topConstant: CGFloat = 0,
              bottomConstant: CGFloat = 0,
              height: CGFloat = 0,
              width: CGFloat = 0,
              heightMult: CGFloat? = nil,
              widthMult: CGFloat? = nil) {

    translatesAutoresizingMaskIntoConstraints = false

    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
    }

    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
    }

    if let top = top {
      topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
    }

    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
    }

    if width > 0 {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    if height > 0 {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    if let heightMult = heightMult, let superview = superview {
      anchorHeightProportionally(to: superview.heightAnchor, multiplier: heightMult)
    }

    if let widthMult = widthMult, let superview = superview {
      anchorWidthProportionally(to: superview.widthAnchor, multiplier: widthMult)
    }
  }
  
  // MARK: - Proportional Sizing
  
  func anchorHeightProportionally(to dimension: NSLayoutDimension, multiplier: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
  }

  func anchorWidthProportionally(to dimension: NSLayoutDimension, multiplier: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
  }

}
