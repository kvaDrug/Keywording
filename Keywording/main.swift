//
//  main.swift
//  Keywording
//
//  Created by Vladimir Kelin on 8/23/18.
//  Copyright © 2018 Vladimir Kelin. All rights reserved.
//

import Foundation

let output = Output()
let input = Input(arguments: Array(CommandLine.arguments.dropFirst()))
let countries = [Country](csvString: Constants.availableCountriesCSV)

func processAndPrintResutls(forKeywords keywords: [String], countryCodes codes: [String]) {
  process(keywords: keywords, countryCodes: codes) { statsArray in
    let statsSortedByCountry = statsArray.sorted { $0.countryCode < $1.countryCode }
    output.printStoreStats(statsSortedByCountry)
    
    exit(EXIT_SUCCESS)
  }
}

switch input {
case .invalid:
  output.printHelp()
  exit(EXIT_FAILURE)
  
case .countryList:
  output.printCountryList(countries)
  exit(EXIT_SUCCESS)
  
case .inline(keywords: let keywords, countryCodes: let countryCodes):
  processAndPrintResutls(forKeywords: keywords, countryCodes: countryCodes)
  
case .file(url: let fileURL, countryCodes: let countryCodes):
  let fileString = (try? String(contentsOf: fileURL)) ?? ""
  let delimiters = CharacterSet.newlines.union(.init(charactersIn: ","))
  let keywords = fileString.components(separatedBy: delimiters).map {
    $0.trimmingCharacters(in: .whitespaces)
  }
  if keywords.isEmpty {
    output.printError("keywords not found")
    exit(EXIT_FAILURE)
  } else {
    processAndPrintResutls(forKeywords: keywords, countryCodes: countryCodes)
  }
  break
}

dispatchMain()
