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
  
  var viewModel = GameViewModel()
  
  var presentingViewController: UIViewController? = nil
  
  convenience init(presentingViewController: UIViewController) {
    self.init()
    self.presentingViewController = presentingViewController
  }
  
  func presentMain() {
    let mainController = MainController.instantiate()
    mainController.viewModel = viewModel
    mainController.delegate = self
    
    let navController = UINavigationController(rootViewController: mainController)
    
    navController.modalPresentationStyle = .fullScreen
    
    presentingViewController?.present(navController, animated: true, completion: nil)
  }
}

extension MainCoordinator: MainControllerDelegate {

  func didTapGame(forIndexPath indexPath: IndexPath, controller: MainController) {
    guard let navController = controller.navigationController else { return }

    let gameList = viewModel.gameList.value
    let filteredList = viewModel.filteredList.value
    
    let selectedGame = filteredList.isEmpty ? gameList[indexPath.row] : filteredList[indexPath.row]

    let gameInfoViewModel = GameInfoViewModel(game: selectedGame)
    let gameInfoCoordinator = GameInfoCoordinator(navController: navController)
    
    gameInfoCoordinator.pushGameInfo(forViewModel: gameInfoViewModel)
  }
}
