//
//  PDTapGestureRecognizer.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 4/17/18.
//  Copyright © 2018 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

/// A testable subclass of `UITapGestureRecognizer`.
class PDTapGestureRecognizer: UITapGestureRecognizer {

  let testTarget: Any?
  let testAction: Selector?

  var testState: UIGestureRecognizerState?
  var testLocation: CGPoint?

  // MARK: - Overrides

  override init(target: Any?, action: Selector?) {
    testTarget = target
    testAction = action
    super.init(target: target, action: action)
  }

  override var state: UIGestureRecognizerState {
    set {
        super.state = newValue
    }
    get {
        if let testState = testState {
            return testState
        }

        return super.state
    }
  }

  override func location(in view: UIView?) -> CGPoint {
    if let testLocation = testLocation {
      return testLocation
    }

    return super.location(in: view)
  }

  // MARK: - Test Touches

  func performTouch(location: CGPoint?, state: UIGestureRecognizerState) {
    testLocation = location
    testState = state

    if let action = testAction {
      (testTarget as AnyObject).perform(action, on: .current, with: self, waitUntilDone: true)
    }
  }

}
