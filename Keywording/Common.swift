//
//  Common.swift
//  keywording
//
//  Created by Vladimir Kelin on 2/24/19.
//  Copyright © 2019 Vladimir Kelin. All rights reserved.
//

import Foundation

var executableName: String {
  return (CommandLine.arguments[0] as NSString).lastPathComponent
}
