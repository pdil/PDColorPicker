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

    beforeEach {
      let window = UIWindow(frame: UIScreen.main.bounds)
      vc = UIViewController()

      window.rootViewController = vc
      window.makeKeyAndVisible()
    }

    describe("a PDColorPickerViewController") {
      context("when cancel is tapped") {
        it("returns a nil color") {
          let colorPickerVC = PDColorPickerViewController {
            newColor in

            expect(newColor).toEventually(beNil())
          }

          vc.present(colorPickerVC, animated: true)
          colorPickerVC.cancelButton.sendActions(for: .touchUpInside)
        }
      }

      context("when save is tapped") {
        it("returns the correct color") {
          let startColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
          let colorPickerVC = PDColorPickerViewController(current: startColor) {
            newColor in

            expect(newColor).toNotEventually(beNil())
            expect(newColor!.uiColor).toEventually(equal(startColor))
          }

          vc.present(colorPickerVC, animated: true)
          colorPickerVC.saveButton.sendActions(for: .touchUpInside)
        }
      }
    }
  }

}
