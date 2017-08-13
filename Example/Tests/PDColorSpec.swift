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
    describe("a PDColor") {
      let original = UIColor(hue: 0.5, saturation: 0.5, brightness: 0.5, alpha: 1)
      let color = PDColor(fromColor: original)

      context("when initialized with UIColor") {
        it("correctly assigns values") {
          expect(color.uiColor).to(equal(original))
        }
      }

      context("when initialized with a 3 component string") {
        it("correctly assigns values") {
          let stringColor3 = PDColor(fromString: "0.5,0.5,0.5")  // default alpha = 1.0

          expect(stringColor3).toNot(beNil())
          expect(stringColor3!.uiColor).to(equal(original))
        }

        it("fails for invalid values") {
          let invalidStringColor3 = PDColor(fromString: "car,0.5,0.5")
          expect(invalidStringColor3).to(beNil())
        }
      }

      context("when initialized with a 4 component string") {
        it("correctly assigns values") {
          let stringColor4 = PDColor(fromString: "0.5,0.5,0.5,1.0")

          expect(stringColor4).toNot(beNil())
          expect(stringColor4!.uiColor).to(equal(original))
        }

        it("fails for invalid values") {
          let invalidStringColor4 = PDColor(fromString: "car,0.5,0.5,1.0")
          expect(invalidStringColor4).to(beNil())
        }
      }

      context("when initialized with an invalid string") {
        let invalidColor = PDColor(fromString: "99999/*60")

        it("fails") {
          expect(invalidColor).to(beNil())
        }
      }

      context("when initialized with HSB") {
        let hsbColor = PDColor(h: 0.5, s: 0.5, b: 0.5, a: 1)

        it("correctly assigns values") {
          expect(hsbColor.uiColor).to(equal(original))
        }
      }

      it("produces correct description string") {
        expect(color.description).to(equal("0.5,0.5,0.5,1.0"))
      }

      it("produces correct hexadecimal string") {
        expect(color.hex).to(equal("#3f7f7f"))
      }

      it("produces correct RGBA values") {
        let rgba = color.rgba

        expect(rgba.r).to(equal(CGFloat(0.25)))
        expect(rgba.g).to(equal(CGFloat(0.50)))
        expect(rgba.b).to(equal(CGFloat(0.50)))
        expect(rgba.a).to(equal(CGFloat(1.00)))
      }

      describe("the foreground color") {
        context("when PDColor is dark") {
          let dark = UIColor(hue: 1, saturation: 1, brightness: 0.25, alpha: 1)
          let darkColor = PDColor(fromColor: dark)

          it("is white") {
            expect(darkColor.appropriateForegroundColor).to(equal(UIColor.white))
          }
        }

        context("when PDColor is light") {
          let light = UIColor(hue: 1, saturation: 0.25, brightness: 0.75, alpha: 1)
          let lightColor = PDColor(fromColor: light)

          it("is black") {
            expect(lightColor.appropriateForegroundColor).to(equal(UIColor.black))
          }
        }
      }
    }
  }

}
