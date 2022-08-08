//
//  AnyTargetConvertable.swift
//  Networking
//
//  Created by Alfauser on 08.08.2022.
//

import Moya

public protocol AnyTargetConvertible {
    var any: AnyTarget { get }
}

public extension AnyTargetConvertible where Self: TargetType {
    var any: AnyTargetConvertible {
        return AnyTarget(target: self)
    }
}
