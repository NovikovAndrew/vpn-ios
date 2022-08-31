//
//  AuthTokenRepo.swift
//  Networking
//
//  Created by Alfauser on 31.08.2022.
//

import SwiftKeychainWrapper

class AuthTokenRepo: AuthTokenRepoPresentable {
    
    // MARK: - Nested types
    
    private enum Constants {
        static let userPhoneKey = "userPhoneKey"
        static let accessTokenKey = "accessTokenEncrypted"
        static let refreshTokenKey = "refreshTokenEncrypted"
    }
    
    // MARK: - Private properties
    
    private let keychainWrapper: KeychainWrapper
    private var tempAccessToken: String?
    private var tempRefreshToken: String?
    
    init(keychainWrapper: KeychainWrapper = .standard) {
        self.keychainWrapper = keychainWrapper
    }
    
    // MARK: - Instance methods
    
    func set(userPhone: String) {
        keychainWrapper.set(userPhone, forKey: Constants.userPhoneKey)
    }
    
    func set(accessToken: String) {
        tempAccessToken = accessToken
    }
    
    
    func set(refreshToken: String) {
        tempRefreshToken = refreshToken
    }
    
    func flushAccessToken() {
        tempAccessToken = nil
        keychainWrapper.removeObject(forKey: Constants.accessTokenKey)
    }
    
    
    func getUserPhone() -> String {
        return keychainWrapper.string(forKey: Constants.userPhoneKey) ?? ""
    }
    
    func getAccessToken() -> String {
        return tempAccessToken ?? ""
    }
    
    func getRefreshToken() -> String {
        return tempRefreshToken ?? ""
    }
    
    func getEncryptedAccessToken() -> String? {
        return keychainWrapper.string(forKey: Constants.accessTokenKey)
    }
    
    func getEncryptedRefreshToken() -> String? {
        return keychainWrapper.string(forKey: Constants.refreshTokenKey)
    }
    
    func save(encryptedAccessToken: String) {
        keychainWrapper.set(encryptedAccessToken, forKey: Constants.accessTokenKey)
    }
    
    func save(encryptedRefreshToken: String) {
        keychainWrapper.set(encryptedRefreshToken, forKey: Constants.refreshTokenKey)
    }
    
    func flushTokens() {
        flushAccessToken()
        tempRefreshToken = nil
        keychainWrapper.removeObject(forKey: Constants.userPhoneKey)
        keychainWrapper.removeObject(forKey: Constants.refreshTokenKey)
    }
}

