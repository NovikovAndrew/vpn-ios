//
//  AuthRepository.swift
//  Networking
//
//  Created by Alfauser on 31.08.2022.
//

import Foundation

class AuthRepository: AuthRepositoryPresentable {
    
    // MARK: - Private proprties
    
    private let networking: NetworkingType
    private let authTokenRepo: AuthTokenRepoPresentable
    
    // MARK: - Nested types
    
    private typealias Target = AuthTarget
    
    // MARK: - Object livecycle
    
    init(networking: NetworkingType,
         authTokenRepo: AuthTokenRepoPresentable) {
        self.networking = networking
        self.authTokenRepo = authTokenRepo
    }
}
