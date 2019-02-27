//
//  Country.swift
//  keywording
//
//  Created by Vladimir Kelin on 2/24/19.
//  Copyright © 2019 Vladimir Kelin. All rights reserved.
//

import Foundation

struct Country {
  let code: String
  let name: String
}


extension Array where Element == Country {
  /// The CSV string should be like "name,code"
  init(csvString: String) {
    let countryStrings = csvString.components(separatedBy: .newlines)
    let countries = countryStrings.map { (s: String) -> Country in
      let values = s.components(separatedBy: ",")
      return Country(code: values[1], name: values[0])
    }
    self.init(countries)
  }
}
