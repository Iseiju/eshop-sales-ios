//
//  StoryboardInstantiable.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 02/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation
import UIKit

////////////////////////////////////////////////////////////////////////////////////////////////////

public protocol StoryboardInstantiable {
  static var storyboardName: String { get }
  static var storyboardBundle: Bundle? { get }
  static var storyboardIdentifier: String? { get }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

extension StoryboardInstantiable {
  
  public static var storyboardIdentifier: String? {
    return String(describing: Self.self)
  }
  
  public static var storyboardBundle: Bundle? {
    return nil
  }
  
  public static func instantiate() -> Self {
    let storyboard = UIStoryboard(name: storyboardName,
                                  bundle: storyboardBundle)
    
    guard let storyboardIdentifier = storyboardIdentifier else {
      return storyboard.instantiateInitialViewController() as! Self
    }
    
    return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
