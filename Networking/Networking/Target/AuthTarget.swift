//
//  AuthTarget.swift
//  Networking
//
//  Created by Alfauser on 04.08.2022.
//

import Foundation

enum AuthTarget {
    case auth(request: AuthRequest)
    case register(request: RegisterRequest)
}
