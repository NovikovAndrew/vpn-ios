//
//  RegisterRequest.swift
//  Networking
//
//  Created by Alfauser on 04.08.2022.
//

import Foundation

public struct RegisterRequest: Decodable {
    let email: String
    let phone: String
    let password: String
    
    public init(email: String, phone: String, password: String) {
        self.email = email
        self.phone = phone
        self.password = password
    }
}
