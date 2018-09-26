//
//  ViewController.swift
//  PDColorReceiverExample
//
//  Created by Paolo Di Lorenzo on 8/16/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit
import PDColorPicker

class ViewController: UIViewController {

  // MARK: - Subviews

  lazy var colorLabel: UILabel = {
    let label = UILabel()

    label.font = UIFont.systemFont(ofSize: 72, weight: .light)
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.25
    label.text = "Drag a color here!"

    return label
  }()

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    setupViews()

    if #available(iOS 11.0, *) {
      let dropInteraction = UIDropInteraction(delegate: self)
      view.addInteraction(dropInteraction)
    }
  }

  private func setupViews() {
    view.addSubview(colorLabel)
    colorLabel.translatesAutoresizingMaskIntoConstraints = false

    colorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    colorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    colorLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.9, constant: 0).isActive = true
  }

}

// MARK: - UIDropInteraction
@available(iOS 11.0, *)
extension ViewController: UIDropInteractionDelegate {
  func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
    return session.canLoadObjects(ofClass: UIColor.self)
  }

  func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
    return UIDropProposal(operation: .copy)
  }

  func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
    session.loadObjects(ofClass: UIColor.self) {
      guard let color = $0.first as? UIColor else { return }
      let pdColor = PDColor(color: color)

      self.view.backgroundColor = color
      self.colorLabel.text = pdColor.hex
      self.colorLabel.textColor = pdColor.appropriateForegroundColor
    }
  }
}
