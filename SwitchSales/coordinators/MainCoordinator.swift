//
//  MainCoordinator.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator {
  
  var presentingViewController: UIViewController? = nil
  
  convenience init(presentingViewController: UIViewController) {
    self.init()
    self.presentingViewController = presentingViewController
  }
  
  func presentMain() {
    let mainController = MainController.instantiate()
    mainController.delegate = self
    
    let navController = UINavigationController(rootViewController: mainController)
    presentingViewController?.present(navController, animated: true, completion: nil)
  }
}

extension MainCoordinator: MainDelegate {

  func didTapGame(forIndexPath indexPath: IndexPath, viewModel: GameViewModel, navController: UINavigationController) {
    let game = viewModel.gameList[indexPath.row]
    let gameInfoViewModel = GameInfoViewModel(game: game)
    let gameInfoCoordinator = GameInfoCoordinator(navController: navController)
    
    gameInfoCoordinator.pushGameInfo(forViewModel: gameInfoViewModel)
  }
  
  func toSearchGame(navController: UINavigationController) {
    let searchGameCoordinator = SearchGameCoordinator(navController)
    searchGameCoordinator.presentSearch()
  }
}
