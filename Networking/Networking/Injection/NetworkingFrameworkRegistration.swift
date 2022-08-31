//
//  NetworkingFrameworkRegistration.swift
//  Networking
//
//  Created by Alfauser on 04.08.2022.
//

import Utilities
import Swinject

public class NetworkingFrameworkRegistration: FrameworkRegistrationPresentable {
    public init() {}
    
    public func register(container: Container) {
        /// AuthTokenRepoPresentable <--->
        container.register(AuthTokenRepoPresentable.self) { resolver in
            return AuthTokenRepo()
        }
        
        /// AuthRepositoryPresentable <---> AuthRepository
        container.register(AuthRepositoryPresentable.self) { resolver in
            return AuthRepository(networking: resolver.resolve(NetworkingType.self)!,
                                  authTokenRepo: resolver.resolve(AuthTokenRepoPresentable.self)!)
        }
        
        /// NetworkingType <---> Networking
        container.register(NetworkingType.self) { resolver in
            return Networking()
        }.initCompleted { resolver, networkType in
            if let networking = networkType as? Networking {
                networking.requestResolver = resolver.resolve(PreRequestResolver.self)
            }
        }
    }
}
