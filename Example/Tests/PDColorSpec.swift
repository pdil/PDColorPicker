//
//  PDColorSpec.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import PDColorPicker

class PDColorSpec: QuickSpec {

  override func spec() {
    describe("a color") {
      let original = UIColor(hue: 0.5, saturation: 0.5, brightness: 0.5, alpha: 1.0)
      let color = PDColor(fromColor: original)

      it("correctly assigns values") {
        expect(color.uiColor).to(equal(original))
      }

      it("produces correct description string") {
        expect(color.description).to(equal("0.5-0.5-0.5-1"))
      }

      it("produces correct hexadecimal string") {
        expect(color.hex).to(equal("#408080"))
      }
    }
  }

}
