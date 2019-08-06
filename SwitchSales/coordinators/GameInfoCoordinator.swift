//
//  GameInfoCoordinator.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation
import SafariServices
import UIKit

class GameInfoCoordinator {
  
  var navController: UINavigationController? = nil
  
  convenience init(navController: UINavigationController) {
    self.init()
    self.navController = navController
  }
  
  func pushGameInfo(forViewModel viewModel: GameInfoViewModel) {
    let gameInfoController = GameInfoController.instantiate()
    gameInfoController.delegate = self
    gameInfoController.viewModel = viewModel

    navController?.pushViewController(gameInfoController, animated: true)
  }
}

extension GameInfoCoordinator: GameInfoDelegate {
  
  func toEshop(controller: GameInfoController, url: String) {
    guard let eShopUrl = URL(string: url) else { return }
    let safariController = SFSafariViewController(url: eShopUrl)
    controller.present(safariController, animated: true, completion: nil)
  }
}
