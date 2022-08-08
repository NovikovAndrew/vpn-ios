//
//  VPNConfigTypes.swift
//  Utilities
//
//  Created by Alfauser on 08.08.2022.
//

import Foundation

/// Wrapper for Build configuration and fetching config vars
public protocol VPNConfigTypes {
    /// Fetches Config value by its key
    ///
    /// - Parameter key: Key String
    /// - Returns: Config Value from plist or nil
    func get(key: VPNConfigKey) -> String
    /// Fetches Boolean Config value by its key
    ///
    /// - Parameter key: Key String
    /// - Returns: Config Value from plist or nil
    func getBool(key: VPNConfigKey) -> Bool?
    /// Sets String Value by its key
    ///
    /// - Parameter value: String value
    /// - Parameter key: Key String
    func set(value: String, key: VPNConfigKey)
}
