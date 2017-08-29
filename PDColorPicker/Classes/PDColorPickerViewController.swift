//
//  PDColorPickerViewController.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/8/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

/// Creates a modal color picker view that allows the user
/// to select hue, saturation, and brightness values in an
/// easy to use, fast interface.
///
/// To present the view controller, execute the following
///   from the presenting view controller:
///
///     let colorPickerVC = PDColorPickerViewController { _ in
///       // handle completion
///     }
///     present(colorPickerVC, animated: true)
///
/// **Note** Dimming the presenting view controller is recommended
///   for a better appearance.
///   See the `Dimmable` protocol.
@available(iOS 9.0, *)
open class PDColorPickerViewController: UIViewController {

  private struct LocalConstants {
    static let padding: CGFloat = 8
  }

  // MARK: - Buttons

  lazy var saveButton: PDRoundedRectButton = {
    let button = PDRoundedRectButton(title: "Save", backColor: .white, foreColor: self.tintColor)

    button.addTarget(self, action: #selector(savePressed(_:)), for: .touchUpInside)
    button.titleLabel?.font = self.boldFont

    return button
  }()

  lazy var cancelButton: PDRoundedRectButton = {
    let button = PDRoundedRectButton(title: "Cancel", backColor: .white, foreColor: .red)

    button.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
    button.titleLabel?.font = self.font

    return button
  }()

  // MARK: - Color Picking Views

  lazy var colorPickerView: PDColorPickerGridView = {
    let pickerView = PDColorPickerGridView()
    pickerView.delegate = self
    pickerView.dataSource = self
    return pickerView
  }()

  lazy var colorSliderView: PDColorPickerSliderView = {
    let sliderView = PDColorPickerSliderView()
    sliderView.delegate = self
    return sliderView
  }()

  let selectedColorLabel: UILabel = {
    let label = UILabel()

    label.clipsToBounds = true
    label.textAlignment = .center

    label.layer.borderWidth = 1.0
    label.layer.borderColor = UIColor.black.cgColor

    label.isUserInteractionEnabled = true

    return label
  }()

  // MARK: - Properties

  /// The tint color of the **Save** button.
  open var tintColor: UIColor {
    didSet {
      saveButton.foreColor = tintColor
    }
  }

  /// The currently selected color of the color picker.
  open var currentColor: PDColor

  /// The completion handler that is called when the color picker is dismissed.
  open var completion: (PDColor?) -> ()

  /// Whether or not to display the hexadecimal code in the selected color preview.
  /// The default value is `true`.
  open var showHexString = true

  /// The font to be used on the **Cancel** button and color preview.
  ///
  /// The default value is the system font at size 18.
  open var font: UIFont = UIFont.systemFont(ofSize: 18) {
    didSet {
      cancelButton.titleLabel?.font = font
      selectedColorLabel.font = font
    }
  }

  /// The font to be used on the **Save** button.
  ///
  /// The default value is the bold system font at size 18.
  open var boldFont: UIFont = UIFont.boldSystemFont(ofSize: 18) {
    didSet {
      saveButton.titleLabel?.font = boldFont
    }
  }

  override open var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

  // MARK: - Initializer

  public init(initialColor: UIColor = .red, tintColor: UIColor = .blue, completion: @escaping (PDColor?) -> () = { _ in }) {
    self.currentColor = PDColor(color: initialColor)
    self.tintColor = tintColor
    self.completion = completion

    super.init(nibName: nil, bundle: nil)

    modalPresentationStyle = .overCurrentContext
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life Cycle

  override open func viewDidLoad() {
    super.viewDidLoad()

    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.6
    view.layer.shadowRadius = 15
    view.layer.shadowOffset = CGSize(width: 0, height: 5)
    view.backgroundColor = .lightGray
    
    setupViews()
  }

  private func setupViews() {
    view.addSubview(colorPickerView)
    colorPickerView.anchor(left: view.leftAnchor, right: view.rightAnchor, top: view.topAnchor)

    view.addSubview(colorSliderView)
    colorSliderView.anchor(left: view.leftAnchor, right: view.rightAnchor, top: colorPickerView.bottomAnchor, leftConstant: LocalConstants.padding, rightConstant: LocalConstants.padding, topConstant: LocalConstants.padding, height: 44)

    let stackView = UIStackView(arrangedSubviews: [cancelButton, saveButton, selectedColorLabel])

    stackView.alignment = .center
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = LocalConstants.padding

    view.addSubview(stackView)
    stackView.anchor(left: view.leftAnchor, right: view.rightAnchor, top: colorSliderView.bottomAnchor, bottom: view.bottomAnchor, leftConstant: LocalConstants.padding, rightConstant: LocalConstants.padding, topConstant: LocalConstants.padding, bottomConstant: LocalConstants.padding, height: 44)

    view.addConstraint(
      NSLayoutConstraint(item: selectedColorLabel, attribute: .height, relatedBy: .equal, toItem: saveButton, attribute: .height, multiplier: 1, constant: 0)
    )

    if #available(iOS 11.0, *) {
      let colorDragInteraction = UIDragInteraction(delegate: self)
      selectedColorLabel.addInteraction(colorDragInteraction)
    }
  }

  override open func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    guard let pvc = presentingViewController else { return }

    let aspectRatio: CGFloat = 0.7

    view.frame.size.height = pvc.view.frame.height * 0.7
    view.frame.size.width = min(view.frame.height * aspectRatio, pvc.view.frame.width * 0.9)

    view.frame.origin.x = pvc.view.frame.width / 2 - view.frame.width / 2
    view.frame.origin.y = pvc.view.frame.height / 2 - view.frame.height / 2

    view.layoutIfNeeded()

    selectedColorLabel.layer.cornerRadius = selectedColorLabel.frame.height / 2

    colorPickerView.currentColor = currentColor
    colorSliderView.currentHue = currentColor.h
    colorPickerView.fadeSlider(.in)

    colorChanged(to: currentColor)
  }

  // MARK: - Button Targets

  @objc func savePressed(_ sender: UIButton) {
    colorPickerView.fadeSlider(.out)

    completion(currentColor)
    dismiss(animated: true, completion: nil)
  }

  @objc func cancelPressed(_ sender: UIButton) {
    colorPickerView.fadeSlider(.out)

    completion(nil)
    dismiss(animated: true, completion: nil)
  }

}

// MARK: - PDColorPickerDataSource
@available(iOS 9.0, *)
extension PDColorPickerViewController: PDColorPickerGridDataSource {
  func selectedHueForColorPicker() -> CGFloat? {
    return currentColor.h
  }
}

// MARK: - PDColorPickerDelegate
@available(iOS 9.0, *)
extension PDColorPickerViewController: PDColorPickerGridDelegate {
  func colorChanged(to newColor: PDColor) {
    currentColor = newColor
    selectedColorLabel.backgroundColor = currentColor.uiColor
    selectedColorLabel.textColor = newColor.appropriateForegroundColor
    selectedColorLabel.text = showHexString ? newColor.hex : ""
  }
}

// MARK: - ColorSliderDelegate
@available(iOS 9.0, *)
extension PDColorPickerViewController: PDColorPickerSliderDelegate {
  func hueChanged(to newHue: CGFloat) {
    currentColor.h = newHue
    colorPickerView.selectedHue = newHue

    colorChanged(to: currentColor)
  }
}

// MARK: - UIDragInteractionDelegate
@available(iOS 11.0, *)
extension PDColorPickerViewController: UIDragInteractionDelegate {
  public func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
    let colorItemProvider = NSItemProvider(object: currentColor.uiColor)
    return [UIDragItem(itemProvider: colorItemProvider)]
  }
}
