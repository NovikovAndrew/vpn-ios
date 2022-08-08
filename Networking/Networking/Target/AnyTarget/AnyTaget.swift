//
//  AnyTaget.swift
//  Networking
//
//  Created by Alfauser on 08.08.2022.
//

import Moya

public final class AnyTarget: BaseProviderType, AnyTargetConvertible {
        
    // MARK: - Instance proprties
    
    public var target: TargetType
    
    // MARK: - Com proprties
    
    public var any: AnyTarget {
        self
    }

    public var buildApiErrorModelOnServerError: Bool {
        guard let target = target as? BaseProviderType else {
            return false
        }
        return target.buildApiErrorModelOnServerError
    }
    
    public var task: Task {
        target.task
    }
    
    public var timeout: TimeInterval {
        guard let target = target as? BaseProviderType
        else { return 60 }
        return target.timeout
    }
    
    // MARK: - Object ive cycle
    
    public init(target: TargetType) {
        self.target = target
    }
}
