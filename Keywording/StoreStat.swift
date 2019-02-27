//
//  StoreStat.swift
//  keywording
//
//  Created by Vladimir Kelin on 2/25/19.
//  Copyright © 2019 Vladimir Kelin. All rights reserved.
//

import Foundation

struct StoreStat {
  let countryCode: String
  
  var resultsByKeyword: [String: SearchResult]
  
  var sortedResultsByKeyword: [(String, SearchResult)] {
    var results = resultsByKeyword.map { (key, value) in (key, value) }
    results.sort { (result1, result2) -> Bool in
      result1.0 < result2.0
    }
    return results
  }
  
  init(countryCode: String) {
    self.countryCode = countryCode
    resultsByKeyword = [:]
  }
}
