//
//  Input.swift
//  keywording
//
//  Created by Vladimir Kelin on 2/24/19.
//  Copyright © 2019 Vladimir Kelin. All rights reserved.
//

import Foundation


enum Input {
  case inline(keywords: [String], countryCodes: [String])
  case file(url: URL, countryCodes: [String])
  case countryList
  case invalid
  
  /// - Parameter arguments: Command line arguments excluding executable.
  init(arguments: [String]) {
    let I = type(of: self)
    
    if let countryList = I.parseConuntryList(arguments: arguments) {
      self = countryList
      return
    }
    
    if let file = I.parseFile(arguments: arguments) {
      self = file
      return
    }

    if let inline = I.parseInline(arguments: arguments) {
      self = inline
      return
    }
    
    self = .invalid
  }
}

// MARK: Parsing
private extension Input {
  static func parseConuntryList(arguments: [String]) -> Input? {
    guard arguments.count == 1 else { return nil }
    guard arguments[0] == Constants.countryListArgument else { return nil }
    return .countryList
  }
  
  static func parseInline(arguments: [String]) -> Input? {
    guard arguments.count >= 2 else { return nil }
    let keywords = arguments[0].split(separator: ",").map {
      $0.trimmingCharacters(in: .whitespaces)
      }
      .filter { !$0.isEmpty }
    guard keywords.count > 0 else { return nil }
    let countryCodes = Array(arguments.dropFirst())
    return .inline(keywords: keywords, countryCodes: countryCodes)
  }
  
  static func parseFile(arguments: [String]) -> Input? {
    guard arguments.count >= 3 else { return nil }
    guard arguments[0] == "-f" else { return nil }
    let fileURL = URL(fileURLWithPath: arguments[1])
    let countryCodes = Array(arguments.dropFirst(2))
    return .file(url: fileURL, countryCodes: countryCodes)
  }
}
