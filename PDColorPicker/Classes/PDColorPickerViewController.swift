//
//  PDColorPickerViewController.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/8/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
open class PDColorPickerViewController: UIViewController {

  private struct LocalConstants {
    static let padding: CGFloat = 8
  }

  // MARK: - Buttons

  lazy var saveButton: PDRoundedRectButton = {
    let button = PDRoundedRectButton(title: "Save", backColor: .white, foreColor: .blue)
    button.addTarget(self, action: #selector(savePressed(_:)), for: .touchUpInside)

    return button
  }()

  lazy var cancelButton: PDRoundedRectButton = {
    let button = PDRoundedRectButton(title: "Cancel", backColor: .white, foreColor: .red)
    button.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)

    return button
  }()

  // MARK: - Color Picking Views

  lazy var colorPickerView: PDColorPickerView = {
    let pickerView = PDColorPickerView()
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

    return label
  }()

  // MARK: - Properties

  open var tintColor: UIColor {
    didSet {
      saveButton.foreColor = tintColor
    }
  }

  open var currentColor: PDColor
  open var completion: (PDColor?) -> ()

  open var showHexString = true

  open var font: UIFont = UIFont.systemFont(ofSize: 18) {
    didSet {
      cancelButton.titleLabel?.font = font
      selectedColorLabel.font = font
    }
  }

  open var boldFont: UIFont = UIFont.boldSystemFont(ofSize: 18) {
    didSet {
      saveButton.titleLabel?.font = boldFont
    }
  }

  override open var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

  // MARK: - Initializer

  init(current: UIColor, tintColor: UIColor, completion: @escaping (PDColor?) -> ()) {
    self.currentColor = PDColor(fromColor: current)
    self.tintColor = tintColor
    self.completion = completion

    super.init(nibName: nil, bundle: nil)
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
  }

  var constraintsHaveBeenSet = false
  override open func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if !constraintsHaveBeenSet {
      guard let pvc = presentingViewController else { return }

      view.frame.size.width = pvc.view.frame.width * 0.9
      view.frame.origin.x = pvc.view.frame.width / 2 - view.frame.width / 2

      view.frame.origin.y = pvc.view.frame.height * 0.2
      view.frame.size.height = pvc.view.frame.height * 0.9 - view.frame.origin.y

      view.layoutIfNeeded()

      selectedColorLabel.layer.cornerRadius = selectedColorLabel.frame.height / 2

      colorPickerView.currentColor = currentColor
      colorSliderView.currentHue = currentColor.h
      colorChanged(to: currentColor)

      constraintsHaveBeenSet = true
    }
  }

  // MARK: - Button Targets

  @objc func savePressed(_ sender: UIButton) {
    completion(currentColor)
    dismiss(animated: true, completion: nil)
  }

  @objc func cancelPressed(_ sender: UIButton) {
    completion(nil)
    dismiss(animated: true, completion: nil)
  }

}

// MARK: - PDColorPickerDataSource
@available(iOS 9.0, *)
extension PDColorPickerViewController: PDColorPickerDataSource {
  func selectedHueForColorPicker() -> CGFloat? {
    return currentColor.h
  }
}

// MARK: - PDColorPickerDelegate
@available(iOS 9.0, *)
extension PDColorPickerViewController: PDColorPickerDelegate {
  func colorChanged(to newColor: PDColor) {
    currentColor = newColor
    selectedColorLabel.backgroundColor = currentColor.uiColor
    selectedColorLabel.textColor = newColor.appropriateForegroundColor
    selectedColorLabel.text = showHexString ? newColor.hex : ""
  }
}

// MARK: - ColorSliderDelegate
@available(iOS 9.0, *)
extension PDColorPickerViewController: PDColorSliderDelegate {
  func hueSelected(_ hue: CGFloat) {
    currentColor.h = hue
    colorPickerView.selectedHue = hue

    colorChanged(to: currentColor)
  }
  
}
