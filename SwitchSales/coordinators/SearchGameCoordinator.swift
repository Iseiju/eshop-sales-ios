//
//  SearchGameCoordinator.swift
//  SwitchSales
//
//  Created by Kenneth James Uy on 06/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation
import UIKit

class SearchGameCoordinator {
  
  var navController: UINavigationController? = nil
  
  convenience init(_ navController: UINavigationController) {
    self.init()
    self.navController = navController
  }
  
  func presentSearch() {
    let searchGameController = SearchGameController.instantiate()
    navController?.pushViewController(searchGameController, animated: true)
  }
}
