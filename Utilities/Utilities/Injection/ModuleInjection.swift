//
//  ModuleInjection.swift
//  Utilities
//
//  Created by Alfauser on 08.08.2022.
//

import Foundation

public protocol ModuleInjection {
    func inject<Dependency>(_ serviceType: Dependency.Type) -> Dependency
    func inject<Dependency>(_ serviceType: Dependency.Type, name: String?) -> Dependency
}

public extension ModuleInjection {
    func inject<Dependency>(_ serviceType: Dependency.Type) -> Dependency {
        inject(serviceType)
    }
}
