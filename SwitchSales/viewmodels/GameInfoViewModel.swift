//
//  GameInfoViewModel.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation

class GameInfoViewModel {
  
  var game: Game? = nil
  
  var url: String {
    return self.game?.url ?? ""
  }
  
  var title: String {
    return self.game?.title ?? ""
  }
  
  var description: String {
    return self.game?.description.htmlToString() ?? ""
  }
  
  var boxArt: String {
    return self.game?.boxArt ?? ""
  }
  
  var releaseDate: String {
    return self.game?.releaseDate ?? ""
  }
  
  var categories: String {
    return self.game?.categories[0] ?? ""
  }
  
  var esrb: String {
    return self.game?.esrb ?? ""
  }
  
  var company: String {
    return self.game?.company[0] ?? ""
  }
  
  var availability: String {
    var availText = ""
    for text in self.game?.availability ?? [""] {
      availText = "\(text)"
    }
    
    return availText
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
