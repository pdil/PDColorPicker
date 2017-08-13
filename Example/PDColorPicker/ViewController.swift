//
//  ViewController.swift
//  PDColorPicker
//
//  Created by dilorenzopl@gmail.com on 08/08/2017.
//  Copyright (c) 2017 dilorenzopl@gmail.com. All rights reserved.
//

import UIKit
import PDColorPicker

class ViewController: UIViewController, Dimmable {

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

    view.backgroundColor = .red

    view.addSubview(chooseColorButton)
    chooseColorButton.translatesAutoresizingMaskIntoConstraints = false
    
    chooseColorButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    chooseColorButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    chooseColorButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    chooseColorButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

  // MARK: - Button Targets

  @objc func chooseColorPressed() {
    let currentColor = view.backgroundColor ?? .red

    let colorPicker = PDColorPickerViewController(current: currentColor, tintColor: .blue) {
      [weak self] newColor in

      self?.undim()

      guard let color = newColor else { return }

      self?.view.backgroundColor = color.uiColor
      self?.chooseColorButton.setTitleColor(color.appropriateForegroundColor, for: .normal)

      self?.setNeedsStatusBarAppearanceUpdate()
    }

    dim()
    present(colorPicker, animated: true)
  }

}

