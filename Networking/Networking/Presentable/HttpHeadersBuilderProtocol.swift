//
//  HttpHeadersBuilderProtocol.swift
//  Networking
//
//  Created by Alfauser on 08.08.2022.
//

import Foundation

public protocol HttpHeadersBuilderProtocol {
    func build() -> [String: String]
    func setDefaultHeaders() -> Self
    func setApiVersion(major: Int, minor: Int, patch: Int) -> Self
}
