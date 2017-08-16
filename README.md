# 🎨 PDColorPicker

[![CI Status](http://img.shields.io/travis/pdil/PDColorPicker.svg?style=flat)](https://travis-ci.org/pdil/PDColorPicker)
[![codecov](https://codecov.io/gh/pdil/PDColorPicker/branch/master/graph/badge.svg)](https://codecov.io/gh/pdil/PDColorPicker)

[![Version](https://img.shields.io/cocoapods/v/PDColorPicker.svg?style=flat)](http://cocoapods.org/pods/PDColorPicker)
[![License](https://img.shields.io/cocoapods/l/PDColorPicker.svg?style=flat)](http://cocoapods.org/pods/PDColorPicker)
[![Platform](https://img.shields.io/cocoapods/p/PDColorPicker.svg?style=flat)](http://cocoapods.org/pods/PDColorPicker)

<img src="https://raw.githubusercontent.com/pdil/PDColorPicker/master/Resources/colorpicker.jpg" width=300>

## 📄 Requirements

* iOS 9.0 or greater
* Xcode 7 or greater

## 💻 Installation

#### Cocoapods

PDColorPicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PDColorPicker'
```

It should be added to the app's target so that it looks something like this:

```ruby
use_frameworks!

target 'MyAppTarget' do
  pod 'PDColorPicker'

  # other pods...
end
```

#### Manually (not recommended)

* Download the `.swift` files inside [PDColorPicker/Classes](https://github.com/pdil/PDColorPicker/tree/master/PDColorPicker/Classes) and add them to your project.
* Add the files to the appropriate target(s) within the project.
* Use the `PDColorPicker` classes as you normally would.

## 📝 Usage

```swift
import UIKit
import PDColorPicker  // 1.

class MyViewController: UIViewController, Dimmable {
  
    // ...
  
    func presentColorPicker() {
        // 2.
        let colorPickerVC = PDColorPickerViewController(initialColor: .blue, tintColor: .black)

        // 3.
        colorPickerVC.completion = {
            [weak self] newColor in

            // 7.
            self?.undim()

            guard let color = newColor else {
                print("The user tapped cancel, no color was selected.")
            }

            let rgb = color.rgba

            print("A new color was selected! RGB: \(rgb.r), \(rgb.g), \(rgb.b)")
         }
  
         // 4.
         dim() // see Dimmable documentation for extra options
    
         // 5.
         present(colorPickerVC, animated: true)
    }
  
    // ...
  
}
```

1. Import the  `PDColorPicker` framework.
2. Instantiate a new `PDColorPickerViewController`.
3. Set the completion handler of the color picker, indicating what the presenting view controller should do with the color result. **Note**: this can also be set in the `PDColorPickerViewController` initializer.
4. Implement the `Dimmable` protocol and dim the presenting view controller (optional but highly recommended).
5. Present the color picker as a modal view controller.
6. Use the color picker to select a color. When **Save** or **Cancel** is tapped, the completion handler specified in the initializer will automatically provide the new color. If the user taps cancel, `nil` is returned.
7. Be sure to undim the view once the completion handler is called.

#### Bonus

To achieve the white status bar while the presenting view controller is dimmed, set `UIViewControllerBasedStatusBarAppearance` to `YES` in your `Info.plist`.

You can also copy the code here into the plist file:
```
<key>UIViewControllerBasedStatusBarAppearance</key>
<true/>
```

Next, in the _presenting_ view controller, include the following code:
```swift
override var preferredStatusBarStyle: UIStatusBarStyle {
  return .lightContent
}
```

## 📲 Example

To run the example project, clone the repo, and run `pod install` from the Example directory.

## 🙋‍♂️ Author

Paolo Di Lorenzo [[Email](mailto:paolo@dilorenzo.pl?subject=PDColorPicker)] [[Website](https://dilorenzo.pl)] [[Twitter](https://twitter.com/dilorenzopl)] [[StackOverflow](https://stackoverflow.com/users/7264964/paolo)]

## ⚖️ License

PDColorPicker is available under the GPL-3.0 license. See the LICENSE file for more info.
