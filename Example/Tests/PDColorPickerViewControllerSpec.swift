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
    }
  }
}
