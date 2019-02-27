//
//  SearchResult.swift
//  keywording
//
//  Created by Vladimir Kelin on 2/25/19.
//  Copyright © 2019 Vladimir Kelin. All rights reserved.
//

import Foundation

enum SearchResult {
  case success(appsCount: Int)
  case connectionError(Error)
  case dataError(String)
}

extension SearchResult: CustomStringConvertible {
  var description: String {
    switch self {
    case .success(appsCount: let count):
      return "\(count)"
      
    case .connectionError(let error):
      return "\(error)"
      
    case .dataError(let msg):
      return msg
    }
  }
}
