//
//  Game.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 02/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation

struct Game: Codable {
  
  var id: Int
  var url: String
  var title: String
  var description: String
  var boxArt: String
  var releaseDate: String
  var categories: [String]
  var esrb: String
  var company: [String?]
  var availability: [String]
  var price: Double
  var salePrice: Double
}
