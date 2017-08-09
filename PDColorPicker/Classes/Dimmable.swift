//
//  Dimmable.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/8/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

public protocol Dimmable { }

public extension Dimmable where Self: UIViewController {
  private func createDimView(_ rect: CGRect?, color: UIColor, alpha: CGFloat) -> UIView? {
    guard let rect = rect else { return nil }

    let dimView = UIView(frame: rect)
    dimView.backgroundColor = color
    dimView.alpha = 0

    return dimView
  }

  public func dim(_ color: UIColor = .black, alpha: CGFloat = 0.5, speed: Double = 0.5) {
    guard let mainDimView = createDimView(UIScreen.main.bounds, color: color, alpha: alpha) else { return }

    if let navigationController =  navigationController {
      navigationController.view.addSubview(mainDimView)
    } else {
      view.addSubview(mainDimView)
    }

    let tabBarDimView = createDimView(tabBarController?.tabBar.bounds, color: color, alpha: alpha)

    if let tabBarDimView = tabBarDimView {
      tabBarController?.tabBar.addSubview(tabBarDimView)
    }

    UIView.animate(withDuration: speed, animations: {
      mainDimView.alpha = alpha
      tabBarDimView?.alpha = alpha
    })
  }

  public func undim(_ alpha: CGFloat = 0, speed: Double = 0.5, completion: @escaping () -> Void = {}) {
    UIView.animate(withDuration: speed, animations: {
      self.tabBarController?.tabBar.subviews.last?.alpha = 0

      if let navigationController = self.navigationController {
        navigationController.view.subviews.last?.alpha = 0
      } else {
        self.view.subviews.last?.alpha = 0
      }

      self.view.subviews.last?.alpha = 0

    }, completion: { _ in
      self.tabBarController?.tabBar.subviews.last?.removeFromSuperview()

      if let navigationController = self.navigationController {
        navigationController.view.subviews.last?.removeFromSuperview()
      } else {
        self.view.subviews.last?.removeFromSuperview()
      }

      completion()
    })
  }
}
