//
//  UIView.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation
import UIKit

protocol UIViewProtocol {
  
  func roundCorners(corners: UIRectCorner, radius: CGFloat)
  func height(_ height: CGFloat) -> NSLayoutConstraint
}

extension UIView: UIViewProtocol {

  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
  
  func height(_ height: CGFloat) -> NSLayoutConstraint {
    self.translatesAutoresizingMaskIntoConstraints = false
    let heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
    heightConstraint.isActive = true
    self.updateConstraintsIfNeeded()
    return heightConstraint
  }
}
