//
//  printDEBUG.swift
//  Utilities
//
//  Created by Alfauser on 31.08.2022.
//

import Foundation

public func printDEBUG(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items, separator, terminator)
    #endif
}

public func printDEBUG(_ data: String) {
    #if DEBUG
    print(data)
    #endif
}
