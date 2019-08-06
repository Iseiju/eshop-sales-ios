//
//  DataEnvelope.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 02/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation

/**
 DataEnvelope<T>
 
 A generic data class to represent JSON-object top-level envelopes.
 */
public struct DataEnvelope<T>: Codable where T: Codable {
  
  public var data: T
  
  private enum CodingKeys: String, CodingKey {
    
    case data
  }
}

