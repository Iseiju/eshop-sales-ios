//
//  GameViewModel.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Alamofire
import Foundation
import RxCocoa
import RxSwift
import StatefulTableView

class GameViewModel {
  
  var filteredList = BehaviorRelay<[Game]>(value: [])
  var gameList = BehaviorRelay<[Game]>(value: [])
  
  private let disposeBag = DisposeBag()
  
  private let cellRelay = BehaviorRelay<[GameCellViewModel]>(value: [])
  
  func cellViewModels() -> BehaviorRelay<[GameCellViewModel]> {
    gameList.asObservable().subscribe(onNext: { games in
      let cellViewModel = games.map { game in
        return GameCellViewModel(game: game)
      }

      self.cellRelay.accept(cellViewModel)
    }).disposed(by: disposeBag)
    
    return cellRelay
  }
  
  func search(forQuery query: String) {
    guard !query.isEmpty else {
      let cellViewModel = gameList.value.map { GameCellViewModel(game: $0) }
      cellRelay.accept(cellViewModel)
      return
    }
    
    let games = gameList.value.filter { game in
      return game.title.lowercased().contains(query.lowercased())
    }
    
    filteredList.accept(games)
    
    let cellViewModels = games.map {
      return GameCellViewModel(game: $0)
    }

    cellRelay.accept(cellViewModels)
  }

  func getGamesOnSale(tableView: StatefulTableView, onCompletion completion: @escaping (_ isEmpty: Bool, _ errorOrNil: NSError?) -> Void) {
    let url = "https://switchsales.herokuapp.com/games/eshop-sales"
//    let localhost = "http://localhost:3000/games/eshop-sales"
    
    Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseData { response in
      switch response.result {
      case .success:
        guard let data = response.result.value else { return }
        guard let response = try? JSONDecoder().decode(DataEnvelope<[Game]>.self, from: data) else {
          completion(true, nil)
          return
        }
        
        var games = response.data
        
        games.sort {
          return $0.title < $1.title
        }
        
        self.gameList.accept(games)
        tableView.reloadData()
        completion(data.isEmpty, nil)
        
      case .failure(let error):
        let nserror = error as NSError
        completion(true, nserror)
      }
    }
  }
}
