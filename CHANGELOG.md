# [PDColorPicker v0.8.5](https://github.com/pdil/PDColorPicker/releases/tag/0.8.5)
Released Friday, October 20, 2023.

* Update author email.

# [PDColorPicker v0.8.4](https://github.com/pdil/PDColorPicker/releases/tag/0.8.4)
Released Friday, August 25, 2023.

* Set minimum deployment target to iOS 11.
* Minor updates to ensure compatibility with modern iOS projects.

# [PDColorPicker v0.8.3](https://github.com/pdil/PDColorPicker/releases/tag/0.8.3)
Released Friday, June 14, 2019.

* Updated to support Swift 5.
* Made further fixes to appearance on devices of various orientations and screen sizes.

# [PDColorPicker v0.8.2](https://github.com/pdil/PDColorPicker/releases/tag/0.8.2)
Released on Wednesday, October 24, 2018.

* Renamed `HexStringCase` cases to `upper` and `lower`.
  * `.uppercase` and `.lowercase` are now marked as deprecated and will be removed at a later date (probably version 1.0).
* Fixed appearance of color picker on smaller devices and when device orientation changes.

# [PDColorPicker v0.8.1](https://github.com/pdil/PDColorPicker/releases/tag/0.8.1)
Released on Saturday, October 20, 2018.

* Added ability to select case for hex string (`HexStringCase.uppercase` or `HexStringCase.lowercase`) via the `hexStringCase` property of `PDColorPickerViewController`.
  * Examples: `#02af93` vs `#02AF93`.
* Updated to support Swift 4.2, iOS 12, and Xcode 10.
* Ignore smart invert colors in dimming view to prevent white glow.

# [PDColorPicker v0.8.0](https://github.com/pdil/PDColorPicker/releases/tag/0.8.0)
Released on Tuesday, April 17, 2018.

* Added ability to tap grid/slider to change color (without panning) ([PR #12](https://github.com/pdil/PDColorPicker/pull/12) by [@bennyjr33](https://github.com/bennyjr33))
* Added ability to toggle drag and drop functionality.
  * Set `allowsDragAndDrop` to `true` or `false` in `PDColorPicker`.
* Updated to support Swift 4.1.


# [PDColorPicker v0.7.0](https://github.com/pdil/PDColorPicker/releases/tag/0.7.0)
Released on Tuesday, November 6, 2017.

* Added support for Smart Invert Colors.
  * Set `supportsSmartInvertColors` to `true` or `false` in `PDColorPicker`.
* Added [Pull Request](https://github.com/pdil/PDColorPicker/blob/master/.github/PULL_REQUEST_TEMPLATE.md) and [Issue](https://github.com/pdil/PDColorPicker/blob/master/.github/ISSUE_TEMPLATE.md) templates.

### Bug Fixes
* Changed some property declarations for consistency.
* Fixed `codecov.yml` template.
* Fixed example code in [README](https://github.com/pdil/PDColorPicker/blob/master/README.md)

# [PDColorPicker v0.6.0](https://github.com/pdil/PDColorPicker/releases/tag/0.6.0)
Released on Tuesday, September 19, 2017.

* Now supports Swift 4.0
  * For projects that don't support Swift 4.0, install from the `swift-3.2` branch.

### Minor improvements
* Added Contributing guidelines to repository (will be updated over time)
* Improved code coverage for tests

# [PDColorPicker v0.5.0](https://github.com/pdil/PDColorPicker/releases/tag/0.5.0)
Released on Sunday, September 3, 2017.

### Improvements
* The status bar style no longer needs to be set by the presenting view controller (managed by `PDColorPickerViewController`)

### Bug Fixes
* Fixed issue with slider circle offset not working in `PDColorPickerGridView`
  * This was caused by not checking to see if constraints had already been set in `PDColorPickerViewController`

# [PDColorPicker v0.4.1](https://github.com/pdil/PDColorPicker/releases/tag/0.4.1)
Released on Thursday, August 31, 2017.

### Improvements
* Improved framework documentation

### Bug Fixes
* Fixed rotation issue with dimming view ([issue #8](https://github.com/pdil/PDColorPicker/issues/8))

# [PDColorPicker v0.4.0](https://github.com/pdil/PDColorPicker/releases/tag/0.4.0)
Released on Thursday, August 31, 2017.

### Improvements
* Removed unnecessary layout anchor functions
* Improved framework documentation

# [PDColorPicker v0.3.0](https://github.com/pdil/PDColorPicker/releases/tag/0.3.0)
Released Monday, August 28, 2017.

### Improvements
* Fixed sizing of `PDColorPickerViewController` for different screen sizes (e.g. iPad in multiple split-view sizes)
* Added the following named colors to `PDColor` for convenience:
  * `PDColor.red`
  * `PDColor.orange`
  * `PDColor.yellow`
  * `PDColor.yellowGreen`
  * `PDColor.green`
  * `PDColor.cyan`
  * `PDColor.azure`
  * `PDColor.blue`
  * `PDColor.purple`
  * `PDColor.magenta`
  * `PDColor.pink`
  * `PDColor.white`
  * `PDColor.black`
* Improved framework documentation

# [PDColorPicker v0.2.0](https://github.com/pdil/PDColorPicker/releases/tag/0.2.0)
Released on Friday, August 18, 2017.

### New Features
* Implemented drag-and-drop support for iOS 11
* Created drag-and-drop example

### Other Improvements
* Renamed `PDColor` initializer parameters
  - `PDColor(fromString:)` becomes `PDColor(string:)`
  - `PDColor(fromColor:)` becomes `PDColor(color:)`
* Switched to MIT license
* Added code of conduct
* Improved documentation

# [PDColorPicker v0.1.0](https://github.com/pdil/PDColorPicker/releases/tag/0.1.0)
Released on Wednesday, August 16, 2017.

First release.

### Main Features
* Present a modal color picker view controller.
* Allow user to select hue, saturation, and brightness values.
* Displays hexadecimal value of color (can optionally be removed).
* Customizable interface font and color.
