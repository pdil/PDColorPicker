//
//  PDColor+NamedColors.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/28/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

public extension PDColor {
  /// Convenient representation of the red `PDColor`.
  ///
  /// Its values are `(1.0, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let red = PDColor(h: 1, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the orange `PDColor`.
  ///
  /// Its values are `(30/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let orange = PDColor(h: 30/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the yellow `PDColor`.
  ///
  /// Its values are `(60/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let yellow = PDColor(h: 60/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the yellow-green `PDColor`.
  ///
  /// Its values are `(90/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let yellowGreen = PDColor(h: 90/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the green `PDColor`.
  ///
  /// Its values are `(120/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let green = PDColor(h: 120/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the cyan `PDColor`.
  ///
  /// Its values are `(180/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let cyan = PDColor(h: 180/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the azure `PDColor`.
  ///
  /// Its values are `(210/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let azure = PDColor(h: 210/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the blue `PDColor`.
  ///
  /// Its values are `(240/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let blue = PDColor(h: 240/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the purple `PDColor`.
  ///
  /// Its values are `(270/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let purple = PDColor(h: 270/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the magenta `PDColor`.
  ///
  /// Its values are `(300/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let magenta = PDColor(h: 300/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the pink `PDColor`.
  ///
  /// Its values are `(330/360, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let pink = PDColor(h: 330/360, s: 1, b: 1, a: 1)
  
  /// Convenient representation of the white `PDColor`.
  ///
  /// Its values are `(0.0, 0.0, 1.0, 1.0)` in the HSBA representation.
  public static let white = PDColor(h: 0, s: 0, b: 1, a: 1)
  
  /// Convenient representation of the black `PDColor`.
  ///
  /// Its values are `(0.0, 1.0, 1.0, 1.0)` in the HSBA representation.
  public static let black = PDColor(h: 0, s: 0, b: 0, a: 1)
}
