//
//  search.swift
//  Keywording
//
//  Created by Vladimir Kelin on 8/23/18.
//  Copyright © 2018 Vladimir Kelin. All rights reserved.
//

import Foundation

// https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/
func search(keyword: String, countryCode: String, completion: @escaping (SearchResult) -> ()) {
  let term = keyword.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
  let urlStr = "https://itunes.apple.com/search?term=\(term)&entity=software&limit=200&country=\(countryCode)"
  let url = URL(string: urlStr)!
  
  URLSession.shared.dataTask(with: url) { (responseData, response, error) in
    let result: SearchResult
    if let data = responseData {
      if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any] {
        if let errorMessage = json["errorMessage"] as? String {
          result = .dataError(errorMessage)
        } else if let count = json["resultCount"] as? Int {
          result = .success(appsCount: count)
        } else {
          result = .dataError("parse error")
        }
      } else {
        result = .dataError("parse error")
      }
    } else if let realError = error {
      result = .connectionError(realError)
    } else {
      result = .dataError("unknown error")
    }
    completion(result)
    }.resume()
}
