//
//  ViewController.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/8/2017.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit
import PDColorPicker

class ViewController: UIViewController, Dimmable {

  // Set the status bar style based on the currently selected color
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return chooseColorButton.titleColor(for: .normal) == .black ? .default : .lightContent
  }

  // MARK: - Views
  
  lazy var chooseColorButton: UIButton = {
    let button = UIButton()

    button.setTitle("Tap to choose a color", for: .normal)
    button.addTarget(self, action: #selector(chooseColorPressed), for: .touchUpInside)

    return button
  }()

  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  // MARK: - Button Targets

  /// Displays example of presenting a PDColorPicker and how to handle result in
  ///   the completion handler.
  @objc func chooseColorPressed() {
    let current = view.backgroundColor ?? .red

    /**
     Initializes a PDColorPickerViewController with the initial color,
     button foreground (tint color), and completion handler.

     The completion returns on the main thread so it is suitable for UI manipulation directly.

     The completion handler gives the new color as an optional PDColor object.
     If the user taps **Cancel**, the returned color is `nil`. The color is not `nil` if the
     user taps **Save**.
    */
    let colorPicker = PDColorPickerViewController(initialColor: current, tintColor: .blue) {
      [weak self] newColor in

      // Un-dim the view once the color picker is dismissed
      self?.undim()

      // Check to see if the user selected a new color
      guard let color = newColor else { return }

      // Use the new color to update the view
      self?.view.backgroundColor = color.uiColor
      self?.chooseColorButton.setTitleColor(color.appropriateForegroundColor, for: .normal)

      self?.setNeedsStatusBarAppearanceUpdate()
    }

    // Dim the presenting view controller for a better appearance
    dim()

    // Present the color picker modally
    present(colorPicker, animated: true)
  }

  // MARK: - Convenience

  private func setupView() {
    view.backgroundColor = .red

    view.addSubview(chooseColorButton)
    chooseColorButton.translatesAutoresizingMaskIntoConstraints = false

    chooseColorButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    chooseColorButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    chooseColorButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    chooseColorButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

}

