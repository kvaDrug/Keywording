//
//  Output.swift
//  Keywording
//
//  Created by Vladimir Kelin on 8/23/18.
//  Copyright © 2018 Vladimir Kelin. All rights reserved.
//

import Foundation


class Output {
  func printHelp() {
    print("\(executableName) v\(Constants.version)")
    print("Usage:")
    print("\t\(executableName) \"<comma separated keywords>\" <country code>...")
    print("\t\(executableName) -f <file> <country code>...")
    print("\t\(executableName) \(Constants.countryListArgument)")
  }
  
  func printError(_ message: String) {
    let errorStr = "Error: " + message
    fputs(errorStr, stderr)
    #if DEBUG
    print(errorStr)
    #endif
  }
  
  func printCountryList(_ list: [Country]) {
    for country in list {
      print(country.name, "–", country.code)
    }
  }
  
  func printStoreStats(_ stats: [StoreStat]) {
    for i in 0..<(stats.count - 1) {
      printStoreStat(stats[i])
      print("")
    }
    if let lastStat = stats.last {
      printStoreStat(lastStat)
    }
  }
  
  private func printStoreStat(_ stat: StoreStat) {
    print(stat.countryCode)
    for (keyword, result) in stat.sortedResultsByKeyword {
      print("\(keyword)\t\(result)" )
    }
  }
}

