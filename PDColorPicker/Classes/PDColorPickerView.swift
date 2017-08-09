//
//  PDColorPickerView.swift
//  PDColorPicker
//
//  Created by Paolo Di Lorenzo on 8/8/17.
//  Copyright © 2017 Paolo Di Lorenzo. All rights reserved.
//

import UIKit

protocol PDColorPickerDelegate: class {
  func colorChanged(to newColor: PDColor)
}

protocol PDColorPickerDataSource: class {
  func selectedHueForColorPicker() -> CGFloat?
}

class PDColorPickerView: UIView, UIGestureRecognizerDelegate {

  weak var delegate: PDColorPickerDelegate?
  weak var dataSource: PDColorPickerDataSource?

  var currentColor: PDColor? {
    didSet { setSliderCircle() }
  }

  var selectedHue: CGFloat? {
    didSet {
      guard let selectedHue = selectedHue else { return }
      backgroundColor = UIColor(hue: selectedHue, saturation: 1, brightness: 1, alpha: 1)
    }
  }

  // MARK: - Slider Properties

  let sliderCircle: UIView = {
    let circle = UIView()
    circle.layer.borderColor = UIColor.black.cgColor
    circle.layer.borderWidth = 2.0
    circle.backgroundColor = UIColor.white.withAlphaComponent(0.6)
    return circle
  }()

  lazy var sliderCircleX: NSLayoutConstraint = {
    let constraint = NSLayoutConstraint(item: self.sliderCircle, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 100)
    return constraint
  }()

  lazy var sliderCircleY: NSLayoutConstraint = {
    let constraint = NSLayoutConstraint(item: self.sliderCircle, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 100)
    return constraint
  }()

  let sliderSize: CGFloat = 25
  let visibilityOffset: CGFloat = 60
  let circleGrowthScale: CGFloat = 3

  // MARK: - Initializer

  init() {
    super.init(frame: .zero)

    let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(colorDragged(_:)))
    panRecognizer.delegate = self
    addGestureRecognizer(panRecognizer)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life Cycle

  var initialViewLoad = true
  override func layoutSubviews() {
    super.layoutSubviews()

    setupGradient()

    if initialViewLoad {
      addSubview(sliderCircle)
      sliderCircle.anchor(height: sliderSize, width: sliderSize)
      addConstraints([sliderCircleX, sliderCircleY])

      layoutIfNeeded()
      sliderCircle.layer.cornerRadius = sliderCircle.frame.width / 2
      setSliderCircle()

      initialViewLoad = false
    }
  }

  // MARK: - Setup

  var saturationGradient = CAGradientLayer()
  var brightnessGradient = CAGradientLayer()

  func setupGradient() {
    saturationGradient.removeFromSuperlayer()
    brightnessGradient.removeFromSuperlayer()
    
    saturationGradient = gradientLayerWithEndPoints(CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5), endColor: .white)
    brightnessGradient = gradientLayerWithEndPoints(CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1), endColor: .black)

    layer.addSublayer(saturationGradient)
    layer.addSublayer(brightnessGradient)

    bringSubview(toFront: sliderCircle)
  }

  private func gradientLayerWithEndPoints(_ start: CGPoint, _ end: CGPoint, endColor: UIColor) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()

    gradientLayer.frame = self.bounds
    gradientLayer.colors = [UIColor.clear.cgColor, endColor.cgColor]

    gradientLayer.startPoint = start
    gradientLayer.endPoint = end

    return gradientLayer
  }

  // MARK: - Gesture

  @objc func colorDragged(_ recognizer: UIPanGestureRecognizer) {
    let pos = recognizer.location(in: self)
    let comps = colorComponenentsAtPosition(pos)
    let sliderCenter = constrainPosition(pos, toBounds: bounds)

    delegate?.colorChanged(to: comps)
    sliderCircle.backgroundColor = comps.uiColor

    switch recognizer.state {
    case .began:
      animateCircleSlider(.grow)
    case .changed:
      sliderCircleX.constant = sliderCenter.x
      sliderCircleY.constant = sliderCenter.y - visibilityOffset
    case .ended:
      sliderCircle.backgroundColor = UIColor.white.withAlphaComponent(0.6)
      animateCircleSlider(.shrink)
    default:
      break
    }
  }

  // MARK: - Slider Management

  func setSliderCircle() {
    guard let currentColor = currentColor else { return }

    sliderCircleX.constant = (1 - currentColor.sat) * bounds.width
    sliderCircleY.constant = (1 - currentColor.br) * bounds.height

    sliderCircle.setNeedsLayout()
  }

  func constrainPosition(_ pos: CGPoint, toBounds rect: CGRect) -> CGPoint {
    let x = min(max(pos.x, 0), rect.width)
    let y = min(max(pos.y, 0), rect.height)

    return CGPoint(x: x, y: y)
  }

  enum CircleSliderAnimationType: Int {
    case grow = -1, shrink = 1
  }

  func animateCircleSlider(_ type: CircleSliderAnimationType) {
    let sliderOffsetDirection: CGFloat = CGFloat(type.rawValue)

    // if sliderOffsetDirection = 1, scale = circleGrowthScale, otherwise scale = circleGrowthScale ^ -1
    let scale = pow(circleGrowthScale, -sliderOffsetDirection)

    let transform = sliderCircle.transform.scaledBy(x: scale, y: scale)
    sliderCircleY.constant += visibilityOffset * sliderOffsetDirection

    UIView.animate(withDuration: 0.25, animations: {
      self.sliderCircle.transform = transform
      self.layoutIfNeeded()
    })
  }

  func colorComponenentsAtPosition(_ point: CGPoint) -> PDColor {
    let sat = min(max(bounds.width - point.x, 0) / bounds.width, 1)
    let br = min(max(bounds.height - point.y, 0) / bounds.height, 1)

    return PDColor(hue: dataSource?.selectedHueForColorPicker() ?? 1, sat: sat, br: br, a: 1)
  }

}
