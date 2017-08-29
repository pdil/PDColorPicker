//
//  PDColorPickerGesturesSpec.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/13/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import Quick
import Nimble
@testable import PDColorPicker

class PDColorPickerGesturesSpec: QuickSpec {

  override func spec() {
    var vc: UIViewController!
    var window: UIWindow!

    beforeEach {
      window = UIWindow(frame: UIScreen.main.bounds)
      vc = UIViewController()

      window.rootViewController = vc
      window.makeKeyAndVisible()
    }

    describe("PDColorPickerGridView gestures") {
      var recognizer: PDPanGestureRecognizer!
      var colorPickerVC: PDColorPickerViewController!
      var colorPickerView: PDColorPickerGridView!

      beforeEach {
        colorPickerVC = PDColorPickerViewController(initialColor: .red) { _ in }
        colorPickerView = colorPickerVC.colorPickerView
        recognizer = colorPickerView.panRecognizer

        waitUntil { done in
          vc.present(colorPickerVC, animated: true, completion: done)
        }

        sleep(1)  // make sure the view is fully loaded
      }

      afterEach {
        waitUntil { done in
          vc.dismiss(animated: true, completion: done)
        }

        sleep(1)  // make sure the view is fully dismissed before starting next test
      }

      context("when the gesture begins") {
        it("sets the correct saturation and brightness values") {
          recognizer.performTouch(location: .zero, translation: nil, state: .began)
          recognizer.performTouch(location: colorPickerView.center, translation: nil, state: .changed)

          expect(colorPickerVC.currentColor.s).to(equal(0.5))
          expect(colorPickerVC.currentColor.b).to(equal(0.5))
        }
      }

      context("when the gesture is panned horizontally") {
        it("changes the saturation value") {
          // move 1/4 of the view width to the right
          let x = colorPickerView.bounds.width / 4
          let location = CGPoint(x: x, y: 0)

          recognizer.performTouch(location: .zero, translation: nil, state: .began)
          recognizer.performTouch(location: location, translation: nil, state: .changed)

          expect(colorPickerVC.currentColor.s).toEventually(equal(0.75))
          expect(colorPickerView.sliderCircleX.constant).toEventually(equal(x))
        }
      }

      context("when the gesture is panned vertically") {
        it("changes the brightness value") {
          // move 1/4 of the view height downward
          let y = colorPickerView.bounds.height / 4
          let offset = colorPickerView.visibilityOffset
          let location = CGPoint(x: 0, y: y)

          recognizer.performTouch(location: .zero, translation: nil, state: .began)
          recognizer.performTouch(location: location, translation: nil, state: .changed)

          expect(colorPickerVC.currentColor.b).to(equal(0.75))
          expect(colorPickerView.sliderCircleY.constant).to(equal(y - offset))
        }
      }

      context("when the gesture ends") {
        it("returns the slider circle to the original state") {
          recognizer.performTouch(location: colorPickerView.center, translation: nil, state: .began)
          recognizer.performTouch(location: nil, translation: nil, state: .ended)

          expect(colorPickerView.sliderCircle.transform).to(equal(CGAffineTransform.identity))
          expect(colorPickerView.sliderCircle.backgroundColor).to(equal(UIColor.white.withAlphaComponent(0.6)))
        }
      }
    }

    describe("PDColorPickerSliderView gestures") {
      var recognizer: PDPanGestureRecognizer!
      var colorPickerVC: PDColorPickerViewController!
      var colorSliderView: PDColorPickerSliderView!

      beforeEach {
        colorPickerVC = PDColorPickerViewController(initialColor: .red) { _ in }
        colorSliderView = colorPickerVC.colorSliderView
        recognizer = colorSliderView.panRecognizer

        waitUntil { done in
          vc.present(colorPickerVC, animated: true, completion: done)
        }

        sleep(1)  // make sure the view is fully loaded
      }

      afterEach {
        waitUntil { done in
          vc.dismiss(animated: true, completion: done)
        }

        sleep(1)  // make sure the view is fully dismissed
      }

      context("when the gesture is panned horizontally") {
        it("changes the hue value") {
          // move 1/4 of the view width to the right
          let x = colorSliderView.bounds.width / 4
          let location = CGPoint(x: x, y: 0)

          recognizer.performTouch(location: .zero, translation: nil, state: .began)
          recognizer.performTouch(location: location, translation: nil, state: .changed)

          let expectedHue = x / (colorSliderView.bounds.width - 2 * colorSliderView.borderWidth)

          expect(colorPickerVC.currentColor.h).to(equal(expectedHue))
          expect(colorSliderView.sliderX.constant).to(equal(x))
        }
      }
    }
  }

}
