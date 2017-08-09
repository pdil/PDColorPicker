# PDColorPicker

[![CI Status](http://img.shields.io/travis/dilorenzopl@gmail.com/PDColorPicker.svg?style=flat)](https://travis-ci.org/dilorenzopl@gmail.com/PDColorPicker)
[![Version](https://img.shields.io/cocoapods/v/PDColorPicker.svg?style=flat)](http://cocoapods.org/pods/PDColorPicker)
[![License](https://img.shields.io/cocoapods/l/PDColorPicker.svg?style=flat)](http://cocoapods.org/pods/PDColorPicker)
[![Platform](https://img.shields.io/cocoapods/p/PDColorPicker.svg?style=flat)](http://cocoapods.org/pods/PDColorPicker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS version 9.0 or greater

## Installation

PDColorPicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PDColorPicker"
```

## Usage

1. Instantiate a new `PDColorPickerViewController`:
```
let colorPickerVC = PDColorPickerViewController(current: .blue, tintColor: .black) {
  [weak self] newColor in

  guard let color = newColor else {
    print("User tapped cancel")
  }

  print("A new color was selected! red: \(color.red), green: \(color.green), blue: \(color.blue)")
}
```

2. Dim the current view controller (optional but highly recommended):
```
dim()
```

3. Present the color picker as a modal view controller:
```
colorPickerVC.modalPresentationStyle = .overCurrentContext
present(colorPickerVC, animated: true)
```

4. Use the color picker to select a color. When Save or Cancel is tapped, the completion handler specified in the initializer will automatically provide the new color. If the user taps cancel, `nil` is returned.

## Author

Paolo Di Lorenzo, paolo@dilorenzo.pl

## License

PDColorPicker is available under the GPL-3.0 license. See the LICENSE file for more info.
