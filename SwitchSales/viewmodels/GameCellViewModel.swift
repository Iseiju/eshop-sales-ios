//
//  GameCellViewModel.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation

class GameCellViewModel {
  
  var game: Game? = nil
  
  var title: String {
    return self.game?.title ?? ""
  }
  
  var boxArt: String {
    return self.game?.boxArt ?? ""
  }
  
  var price: Double {
    return self.game?.price ?? 0.0
  }
  
  var salePrice: Double {
    return self.game?.salePrice ?? 0.0
  }
  
  init(game: Game) {
    self.game = game
  }
}
