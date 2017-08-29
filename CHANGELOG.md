# PDColorPicker v0.2.0.9000

### Improvements
* Fixed sizing of `PDColorPickerViewController` for different screen sizes (e.g. iPad in multiple split-view sizes).
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
