//
//  PDColor.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/8/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

public struct PDColor {
  /// hue
  public var h: CGFloat
  /// saturation
  public var s: CGFloat
  /// brightness
  public var b: CGFloat
  /// alpha
  public var a: CGFloat

  public static let red = PDColor(h: 1, s: 1, b: 1, a: 1)

  public var uiColor: UIColor {
    return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
  }

  public var rgba: (r: CGFloat, b: CGFloat, g: CGFloat, a: CGFloat) {
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 0.0

    uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)

    return (r: r, b: b, g: g, a: a)
  }

  public init(fromColor: UIColor) {
    var h: CGFloat = 0
    var s: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    fromColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)

    self.h = h
    self.s = s
    self.b = b
    self.a = a
  }

  public init?(fromString string: String) {
    let components = string.components(separatedBy: ",")

    if components.count >= 3 {
      if let h = Double(components[0]), let s = Double(components[1]), let b = Double(components[2]) {
        self.h = CGFloat(h)
        self.s = CGFloat(s)
        self.b = CGFloat(b)
      } else {
        return nil
      }

      if components.count == 4, let a = Double(components[3]) {
        self.a = CGFloat(a)
      } else {
        a = 1
      }
    } else {
      return nil
    }
  }

  public init(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat = 1) {
    self.h = h
    self.s = s
    self.b = b
    self.a = a
  }

  // MARK: - Utilities

  public var hex: String {
    let rgba = self.rgba

    let rr = (Int)(rgba.r * 255) << 16
    let gg = (Int)(rgba.g * 255) << 8
    let bb = (Int)(rgba.b * 255) << 0

    let rgb = rr | gg | bb

    return String(format: "#%06x", rgb)
  }

  public var appropriateForegroundColor: UIColor {
    let rgba = self.rgba

    let level = 1 - (0.299 * rgba.r + 0.587 * rgba.g + 0.114 * rgba.b)
    let d: CGFloat = level < 0.5 ? 0.0 : 1.0

    return UIColor(red: d, green: d, blue: d, alpha: 1.0)
  }
  
}

// MARK: - CustomStringConveritble

extension PDColor: CustomStringConvertible {
  public var description: String {
    return "\(h),\(s),\(b),\(a)"
  }
}
