//
//  GameViewModel.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Alamofire
import Foundation
import StatefulTableView

class GameViewModel {
  
  var gameList: [Game] = []
  
  var count: Int {
    return self.gameList.count
  }

  func cellViewModels(forIndexPath indexPath: IndexPath) -> GameCellViewModel {
    let cellViewModels = GameCellViewModel(game: self.gameList[indexPath.row])
    
    return cellViewModels
  }

  func getGamesOnSale(controller: MainController,tableView: StatefulTableView, onCompletion completion: @escaping (_ isEmpty: Bool, _ errorOrNil: NSError?) -> Void) {
    let url = "https://switchsales.herokuapp.com/eshop-sales"
    let localhost = "http://localhost:3000/eshop-sales"
    
    Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseData { response in
      guard case .success = response.result else {
        let error = response.result.error! as NSError
        completion(true, error)
        return
      }
      guard let data = response.result.value else { return }
      guard let response = try? JSONDecoder().decode(DataEnvelope<[Game]>.self, from: data) else {
        controller.presentAlert()
        completion(data.isEmpty, nil)
        return
      }
      
      var games = response.data

      games.sort {
        return $0.title < $1.title
      }
      
      self.gameList = games
      tableView.reloadData()
      completion(response.data.isEmpty, nil)
    }
  }
}
