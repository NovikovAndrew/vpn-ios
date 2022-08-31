//
//  AuthTokenRepoPresentable.swift
//  Networking
//
//  Created by Alfauser on 31.08.2022.
//

import Foundation

protocol AuthTokenRepoPresentable {
    func set(userPhone: String)
    func set(accessToken: String)
    /// Removes Access Token stored in keychain and in-memory
    func flushAccessToken()
    func set(refreshToken: String)
    func getUserPhone() -> String
    func getAccessToken() -> String
    func getRefreshToken() -> String
    func getEncryptedAccessToken() -> String?
    func getEncryptedRefreshToken() -> String?
    func save(encryptedAccessToken: String)
    func save(encryptedRefreshToken: String)
    func flushTokens()
}
