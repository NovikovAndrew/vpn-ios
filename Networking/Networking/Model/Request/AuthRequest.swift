//
//  AuthRequest.swift
//  Networking
//
//  Created by Alfauser on 04.08.2022.
//

import Foundation

public struct AuthRequest: Decodable {
    let email: String
    let password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
