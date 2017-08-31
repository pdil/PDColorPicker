//
//  PDColorNamedColorsSpec.swift
//  PDColorPickerTests
//
//  Created by Paolo Di Lorenzo on 8/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import PDColorPicker

class PDColorNamedColorsSpec: QuickSpec {

  override func spec() {
    describe("red") {
      it("produces correct RGB values") {
        let rgb = PDColor.red.rgba

        expect(rgb.r).to(equal(1))
        expect(rgb.g).to(equal(0))
        expect(rgb.b).to(equal(0))
      }

      it("produces correct hex string") {
        expect(PDColor.red.hex).to(equal("#ff0000"))
      }
    }

    describe("orange") {
      it("produces correct RGB values") {
        let rgb = PDColor.orange.rgba

        expect(rgb.r).to(equal(1))
        expect(rgb.g).to(equal(0.5))
        expect(rgb.b).to(equal(0))
      }

      it("produces correct hex string") {
        expect(PDColor.orange.hex).to(equal("#ff7f00"))
      }
    }

    describe("yellow") {
      it("produces correct RGB values") {
        let rgb = PDColor.yellow.rgba

        expect(rgb.r).to(equal(1))
        expect(rgb.g).to(equal(1))
        expect(rgb.b).to(equal(0))
      }

      it("produces correct hex string") {
        expect(PDColor.yellow.hex).to(equal("#ffff00"))
      }
    }

    describe("yellowGreen") {
      it("produces correct RGB values") {
        let rgb = PDColor.yellowGreen.rgba

        expect(rgb.r).to(equal(0.5))
        expect(rgb.g).to(equal(1))
        expect(rgb.b).to(equal(0))
      }

      it("produces correct hex string") {
        expect(PDColor.yellowGreen.hex).to(equal("#7fff00"))
      }
    }

    describe("green") {
      it("produces correct RGB values") {
        let rgb = PDColor.green.rgba

        expect(rgb.r).to(equal(0))
        expect(rgb.g).to(equal(1))
        expect(rgb.b).to(equal(0))
      }

      it("produces correct hex string") {
        expect(PDColor.green.hex).to(equal("#00ff00"))
      }
    }

    describe("cyan") {
      it("produces correct RGB values") {
        let rgb = PDColor.cyan.rgba

        expect(rgb.r).to(equal(0))
        expect(rgb.g).to(equal(1))
        expect(rgb.b).to(equal(1))
      }

      it("produces correct hex string") {
        expect(PDColor.cyan.hex).to(equal("#00ffff"))
      }
    }

    describe("azure") {
      it("produces correct RGB values") {
        let rgb = PDColor.azure.rgba

        expect(rgb.r).to(equal(0))
        expect(rgb.g).to(equal(0.5))
        expect(rgb.b).to(equal(1))
      }

      it("produces correct hex string") {
        expect(PDColor.azure.hex).to(equal("#007fff"))
      }
    }

    describe("blue") {
      it("produces correct RGB values") {
        let rgb = PDColor.blue.rgba

        expect(rgb.r).to(equal(0))
        expect(rgb.g).to(equal(0))
        expect(rgb.b).to(equal(1))
      }

      it("produces correct hex string") {
        expect(PDColor.blue.hex).to(equal("#0000ff"))
      }
    }

    describe("purple") {
      it("produces correct RGB values") {
        let rgb = PDColor.purple.rgba

        expect(rgb.r).to(equal(0.5))
        expect(rgb.g).to(equal(0))
        expect(rgb.b).to(equal(1))
      }

      it("produces correct hex string") {
        expect(PDColor.purple.hex).to(equal("#7f00ff"))
      }
    }

    describe("magenta") {
      it("produces correct RGB values") {
        let rgb = PDColor.magenta.rgba

        expect(rgb.r).to(equal(1))
        expect(rgb.g).to(equal(0))
        expect(rgb.b).to(equal(1))
      }

      it("produces correct hex string") {
        expect(PDColor.magenta.hex).to(equal("#ff00ff"))
      }
    }

    describe("pink") {
      it("produces correct RGB values") {
        let rgb = PDColor.pink.rgba

        expect(rgb.r).to(equal(1))
        expect(rgb.g).to(equal(0))
        expect(rgb.b).to(equal(0.5))
      }

      it("produces correct hex string") {
        expect(PDColor.pink.hex).to(equal("#ff007f"))
      }
    }

    describe("white") {
      it("produces correct RGB values") {
        let rgb = PDColor.white.rgba

        expect(rgb.r).to(equal(1))
        expect(rgb.g).to(equal(1))
        expect(rgb.b).to(equal(1))
      }

      it("produces correct hex string") {
        expect(PDColor.white.hex).to(equal("#ffffff"))
      }
    }

    describe("black") {
      it("produces correct RGB values") {
        let rgb = PDColor.black.rgba

        expect(rgb.r).to(equal(0))
        expect(rgb.g).to(equal(0))
        expect(rgb.b).to(equal(0))
      }

      it("produces correct hex string") {
        expect(PDColor.black.hex).to(equal("#000000"))
      }
    }
  }

}
