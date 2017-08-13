//
//  PDColorPickerViewControllerSpec.swift
//  PDColorPicker_Example
//
//  Created by Paolo Di Lorenzo on 8/13/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import PDColorPicker

class PDColorPickerViewControllerSpec: QuickSpec {

  override func spec() {
    var vc: UIViewController!
    var window: UIWindow!

    beforeEach {
      window = UIWindow(frame: UIScreen.main.bounds)
      vc = UIViewController()

      window.rootViewController = vc
      window.makeKeyAndVisible()
    }

    describe("a PDColorPickerViewController") {
      context("when cancel is tapped") {
        it("returns a nil color") {
          // set to non-nil value to ensure it is set to nil
          var selectedColor: PDColor? = .red

          let colorPickerVC = PDColorPickerViewController {
            selectedColor = $0
          }

          vc.present(colorPickerVC, animated: true)
          colorPickerVC.cancelButton.sendActions(for: .touchUpInside)

          expect(selectedColor).toEventually(beNil())
        }
      }

      context("when save is tapped") {
        it("returns the correct color") {
          var selectedColor: PDColor?

          let startColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
          let colorPickerVC = PDColorPickerViewController(current: startColor) {
            selectedColor = $0
          }

          vc.present(colorPickerVC, animated: true)
          colorPickerVC.saveButton.sendActions(for: .touchUpInside)

          expect(selectedColor).toNotEventually(beNil())
          expect(selectedColor?.uiColor).toEventually(equal(startColor))
        }
      }

      describe("PDColorPickerView gestures") {
        var recognizer: PDPanGestureRecognizer!
        var colorPickerVC: PDColorPickerViewController!
        var colorPickerView: PDColorPickerView!

        beforeEach {
          colorPickerVC = PDColorPickerViewController(current: .red) { _ in }
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

          sleep(1)  // make sure the view is fully dismissed
        }

        context("when the gesture begins") {
          it("sets the correct saturation and brightness values") {
            recognizer.performTouch(location: colorPickerView.center, translation: nil, state: .began)

            expect(colorPickerVC.currentColor.s).to(equal(0.5))
            expect(colorPickerVC.currentColor.b).to(equal(0.5))
          }
        }

        context("when the gesture is panned horizontally") {
          it("changes the saturation value") {
            // move 1/4 of the view width to the right
            let x = colorPickerView.bounds.width / 4
            let location = CGPoint(x: x, y: 0)
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
            recognizer.performTouch(location: location, translation: nil, state: .changed)

            expect(colorPickerVC.currentColor.b).toEventually(equal(0.75))
            expect(colorPickerView.sliderCircleY.constant).toEventually(equal(y - offset))
          }
        }

        context("when the gesture ends") {
          it("returns the slider circle to the original state") {
            recognizer.performTouch(location: colorPickerView.center, translation: nil, state: .began)
            recognizer.performTouch(location: nil, translation: nil, state: .ended)

            expect(colorPickerView.sliderCircle.transform).toEventually(equal(CGAffineTransform.identity))
            expect(colorPickerView.sliderCircle.backgroundColor).toEventually(equal(UIColor.white.withAlphaComponent(0.6)))
          }
        }
      }
    }
  }

}
