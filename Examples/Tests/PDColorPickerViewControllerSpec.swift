//
//  PDColorPickerViewControllerSpec.swift
//  PDColorPicker_Example
//
//  Created by Paolo Di Lorenzo on 8/13/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import Quick
import Nimble
@testable import PDColorPicker

class DimmableViewController: UIViewController, Dimmable {

}

class PDColorPickerViewControllerSpec: QuickSpec {

  override func spec() {
    var vc: DimmableViewController!
    var window: UIWindow!

    beforeEach {
      window = UIWindow(frame: UIScreen.main.bounds)
      vc = DimmableViewController()

      window.rootViewController = vc
      window.makeKeyAndVisible()

      vc.dim()
    }

    describe("a PDColorPickerViewController") {
      context("when cancel is tapped") {
        it("returns a nil color") {
          // set to non-nil value to ensure it is set to nil
          var selectedColor: PDColor? = .red

          let colorPickerVC = PDColorPickerViewController {
            vc.undim()
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
          let colorPickerVC = PDColorPickerViewController(initialColor: startColor) {
            vc.undim()
            selectedColor = $0
          }

          vc.present(colorPickerVC, animated: true)
          colorPickerVC.saveButton.sendActions(for: .touchUpInside)

          expect(selectedColor).toNotEventually(beNil())
          expect(selectedColor?.uiColor).toEventually(equal(startColor))
        }
      }

      context("when font is set") {
        it("appears on views correctly") {
          let font = UIFont.systemFont(ofSize: 5)
          let boldFont = UIFont.boldSystemFont(ofSize: 5)

          let colorPickerVC = PDColorPickerViewController() { _ in }
          colorPickerVC.font = font
          colorPickerVC.boldFont = boldFont

          expect(colorPickerVC.cancelButton.titleLabel?.font).to(equal(font))
          expect(colorPickerVC.selectedColorLabel.font).to(equal(font))
          expect(colorPickerVC.saveButton.titleLabel?.font).to(equal(boldFont))
        }
      }

      context("when tintColor is set") {
        it("appears on views correctly") {
          let tintColor = UIColor.yellow

          let colorPickerVC = PDColorPickerViewController() { _ in }
          colorPickerVC.tintColor = tintColor

          expect(colorPickerVC.saveButton.titleLabel?.textColor).to(equal(tintColor))
        }
      }
    }
  }
}
