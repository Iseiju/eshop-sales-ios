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
    let viewModel = GameViewModel()
    
    let mainController = MainController.instantiate()
    mainController.viewModel = viewModel
    mainController.delegate = self
    
    let navController = UINavigationController(rootViewController: mainController)
    
    navController.modalPresentationStyle = .fullScreen
    
    presentingViewController?.present(navController, animated: true, completion: nil)
  }
}

extension MainCoordinator: MainDelegate {

  func didTapGame(forIndexPath indexPath: IndexPath,
                  viewModel: GameViewModel,
                  controller: MainController) {
    guard let navController = controller.navigationController else { return }
    
    var game: Game? = nil
    
    if viewModel.filteredList.value.isEmpty {
      game = viewModel.gameList.value[indexPath.row]
    } else {
      game = viewModel.filteredList.value[indexPath.row]
    }

    guard let selected = game else { return }
    let gameInfoViewModel = GameInfoViewModel(game: selected)
    let gameInfoCoordinator = GameInfoCoordinator(navController: navController)
    
    gameInfoCoordinator.pushGameInfo(forViewModel: gameInfoViewModel)
  }
}
