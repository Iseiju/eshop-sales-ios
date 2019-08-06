//
//  String.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Foundation

protocol StringProtocol {
  
  func strikeOutText() -> NSMutableAttributedString
  func htmlToString() -> String
  func formatDate(fromFormat: String, toFormat: String) -> String
//  func replaceSymbol(of: String, to: String) -> String
}

extension String: StringProtocol {
  
  func strikeOutText() -> NSMutableAttributedString {
    let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                 value: 2,
                                 range: NSMakeRange(0, attributeString.length))
    
    return attributeString
  }
  
  private func htmlToAttributedString() -> NSAttributedString {
    guard let data = data(using: .utf8) else { return NSAttributedString() }
    do {
      return try NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding:String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
    } catch {
      return NSAttributedString()
    }
  }
  
  func htmlToString() -> String {
    return htmlToAttributedString().string
  }
  
  func formatDate(fromFormat: String, toFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = fromFormat
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
    
    guard let dateObject = dateFormatter.date(from: self) else { return "" }
    
    dateFormatter.dateFormat = toFormat
    
    return dateFormatter.string(from: dateObject)
  }
  
//  func replaceSymbol(of: String, to: String) -> String {
//    return self.replacingOccurrences(of: of, with: to, options: .literal, range: nil)
//  }
}
