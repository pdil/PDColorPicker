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

  // MARK: - Main Anchoring

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

  // MARK: - Centering

  func anchorCenter(in view: UIView? = nil, padding: CGFloat? = nil) {
    guard let centerView = view ?? superview else { superviewError() }
    
    if let padding = padding {
      anchor(
        left: centerView.leftAnchor,
        right: centerView.rightAnchor,
        top: centerView.topAnchor,
        bottom: centerView.bottomAnchor,
        leftConstant: padding,
        rightConstant: padding,
        topConstant: padding,
        bottomConstant: padding
      )
    }

    anchorCenterHorizontally(in: view)
    anchorCenterVertically(in: view)
  }

  func anchorCenterHorizontally(in view: UIView? = nil) {
    guard let view = view ?? superview else { superviewError() }

    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  }

  func anchorCenterVertically(in view: UIView? = nil) {
    guard let view = view ?? superview else { superviewError() }

    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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

  // MARK: - Fill

  func anchorFill(in view: UIView? = nil, padding: CGFloat = 0) {
    guard let fillView = view ?? superview else { superviewError() }

    let paddingInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    anchorFill(in: fillView, paddingInsets: paddingInsets)
  }

  func anchorFill(in view: UIView, paddingInsets: UIEdgeInsets) {
    anchor(
      left: view.leftAnchor,
      right: view.rightAnchor,
      top: view.topAnchor,
      bottom: view.bottomAnchor,
      leftConstant: paddingInsets.left,
      rightConstant: paddingInsets.right,
      topConstant: paddingInsets.top,
      bottomConstant: paddingInsets.bottom
    )
  }

  // MARK: - Error Handling

  private func superviewError() -> Never {
    fatalError("Could not find a superview for view:\n\n\(self.debugDescription)\n\nThe view may not have been added to a superview")
  }

}
