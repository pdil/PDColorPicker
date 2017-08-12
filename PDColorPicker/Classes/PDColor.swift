//
//  PDColor.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/8/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

public struct PDColor {
  public var hue: CGFloat
  public var sat: CGFloat
  public var br: CGFloat
  public var a: CGFloat

  public static let red = PDColor(hue: 1, sat: 1, br: 1, a: 1)

  public var uiColor: UIColor {
    return UIColor(hue: hue, saturation: sat, brightness: br, alpha: a)
  }

  public init(fromColor: UIColor) {
    var h: CGFloat = 0
    var s: CGFloat = 0
    var b: CGFloat = 0
    var alpha: CGFloat = 0

    fromColor.getHue(&h, saturation: &s, brightness: &b, alpha: &alpha)

    self.hue = h
    self.sat = s
    self.br = b
    self.a = alpha
  }

  public init?(fromString string: String) {
    let components = string.components(separatedBy: "-")

    if components.count >= 3 {
      hue = CGFloat(Double(components[0]) ?? 0)
      sat = CGFloat(Double(components[1]) ?? 0)
      br = CGFloat(Double(components[2]) ?? 0)

      if components.count >= 4 {
        a = CGFloat(Double(components[3]) ?? 1)
      } else {
        a = 1
      }
    } else {
      return nil
    }
  }

  public init(hue: CGFloat, sat: CGFloat, br: CGFloat, a: CGFloat = 1) {
    self.hue = hue
    self.sat = sat
    self.br = br
    self.a = a
  }

  // MARK: - Utilities

  public var hex: String {
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0

    uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)

    let rr = (Int)(r * 255) << 16
    let gg = (Int)(g * 255) << 8
    let bb = (Int)(b * 255) << 0

    let rgb = rr | gg | bb

    return String(format: "#%06x", rgb)
  }

  public var appropriateForegroundColor: UIColor {
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0

    uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)

    let level = 1 - (0.299 * r + 0.587 * g + 0.114 * b)
    let d: CGFloat = level < 0.5 ? 0.0 : 1.0

    return UIColor(red: d, green: d, blue: d, alpha: 1.0)
  }
  
}

// MARK: - CustomStringConveritble

extension PDColor: CustomStringConvertible {
  public var description: String {
    return "\(hue)-\(sat)-\(br)-\(a)"
  }
}
