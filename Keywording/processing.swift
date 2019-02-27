//
//  processing.swift
//  keywording
//
//  Created by Vladimir Kelin on 2/25/19.
//  Copyright © 2019 Vladimir Kelin. All rights reserved.
//

import Foundation

func process(keywords: [String], countryCodes: [String], completion: @escaping ([StoreStat]) -> ()) {
  var statsByCountry = [StoreStat]()
  let processDispatchGroup = DispatchGroup()
  for countryCode in countryCodes {
    processDispatchGroup.enter()
    let countryDispatchGroup = DispatchGroup()
    var stat = StoreStat(countryCode: countryCode)
    for word in keywords {
      countryDispatchGroup.enter()
      search(keyword: word, countryCode: countryCode) { (result) in
        stat.resultsByKeyword[word] = result
        countryDispatchGroup.leave()
      }
    }
    countryDispatchGroup.notify(queue: .main) {
      statsByCountry.append(stat)
      processDispatchGroup.leave()
    }
  }
  
  processDispatchGroup.notify(queue: .main) {
    completion(statsByCountry)
  }
}
