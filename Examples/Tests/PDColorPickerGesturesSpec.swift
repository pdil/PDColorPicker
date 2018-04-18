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
      var colorPickerVC: PDColorPickerViewController!
      var colorPickerView: PDColorPickerGridView!
      var panRecognizer: PDPanGestureRecognizer!
      var tapRecognizer: PDTapGestureRecognizer!

      beforeEach {
        colorPickerVC = PDColorPickerViewController(initialColor: .red)
        colorPickerView = colorPickerVC.colorPickerView
        panRecognizer = colorPickerView.panRecognizer
        tapRecognizer = colorPickerView.tapRecognizer

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

      context("when the pan gesture begins") {
        it("sets the correct saturation and brightness values") {
          panRecognizer.performTouch(location: .zero, translation: nil, state: .began)
          panRecognizer.performTouch(location: colorPickerView.center, translation: nil, state: .changed)

          expect(colorPickerVC.currentColor.s).to(equal(0.5))
          expect(colorPickerVC.currentColor.b).to(equal(0.5))
        }
      }

      context("when the view is panned horizontally") {
        it("changes the saturation value") {
          // move 1/4 of the view width to the right
          let x = colorPickerView.bounds.width / 4
          let location = CGPoint(x: x, y: 0)

          panRecognizer.performTouch(location: .zero, translation: nil, state: .began)
          panRecognizer.performTouch(location: location, translation: nil, state: .changed)

          expect(colorPickerVC.currentColor.s).toEventually(equal(0.75))
          expect(colorPickerView.sliderCircleX.constant).toEventually(equal(x))
        }
      }

      context("when the view is panned vertically") {
        it("changes the brightness value") {
          // move 1/4 of the view height downward
          let y = colorPickerView.bounds.height / 4
          let offset = colorPickerView.visibilityOffset
          let location = CGPoint(x: 0, y: y)

          panRecognizer.performTouch(location: .zero, translation: nil, state: .began)
          panRecognizer.performTouch(location: location, translation: nil, state: .changed)

          expect(colorPickerVC.currentColor.b).to(equal(0.75))
          expect(colorPickerView.sliderCircleY.constant).to(equal(y - offset))
        }
      }

      context("when the pan gesture ends") {
        it("returns the slider circle to the original state") {
          panRecognizer.performTouch(location: colorPickerView.center, translation: nil, state: .began)
          panRecognizer.performTouch(location: nil, translation: nil, state: .ended)

          expect(colorPickerView.sliderCircle.transform).to(equal(CGAffineTransform.identity))
          expect(colorPickerView.sliderCircle.backgroundColor).to(equal(UIColor.white.withAlphaComponent(0.6)))
        }
      }

      context("when the view is tapped") {
        it("changes the brightness and saturation values") {
          tapRecognizer.performTouch(location: colorPickerView.center, state: .began)

          expect(colorPickerVC.currentColor.s).to(equal(0.5))
          expect(colorPickerVC.currentColor.b).to(equal(0.5))
        }
      }
    }

    describe("PDColorPickerSliderView gestures") {
      var colorPickerVC: PDColorPickerViewController!
      var colorSliderView: PDColorPickerSliderView!
      var panRecognizer: PDPanGestureRecognizer!
      var tapRecognizer: PDTapGestureRecognizer!

      beforeEach {
        colorPickerVC = PDColorPickerViewController(initialColor: .red)
        colorSliderView = colorPickerVC.colorSliderView
        panRecognizer = colorSliderView.panRecognizer
        tapRecognizer = colorSliderView.tapRecognizer

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

      context("when the view is panned horizontally") {
        it("changes the hue value") {
          // move 1/4 of the view width to the right
          let x = colorSliderView.bounds.width / 4
          let location = CGPoint(x: x, y: 0)

          panRecognizer.performTouch(location: .zero, translation: nil, state: .began)
          panRecognizer.performTouch(location: location, translation: nil, state: .changed)

          let expectedHue = x / (colorSliderView.bounds.width - 2 * colorSliderView.borderWidth)

          expect(colorPickerVC.currentColor.h).to(equal(expectedHue))
          expect(colorSliderView.sliderX.constant).to(equal(x))
        }
      }

      context("when the view is tapped") {
        it("changes the hue value") {
          // tap at 1/4 of the view width to the right
          let x = colorSliderView.bounds.width / 4
          let location = CGPoint(x: x, y: 0)

          tapRecognizer.performTouch(location: .zero, state: .began)
          tapRecognizer.performTouch(location: location, state: .changed)

          let expectedHue = x / (colorSliderView.bounds.width - 2 * colorSliderView.borderWidth)

          expect(colorPickerVC.currentColor.h).to(equal(expectedHue))
          expect(colorSliderView.sliderX.constant).to(equal(x))
        }
      }
    }
  }

}
