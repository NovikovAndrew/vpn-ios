//
//  PreRequestResolver.swift
//  Networking
//
//  Created by Alfauser on 31.08.2022.
//

import Moya

public class PreRequestResolver {
    
    private static let accessTokenToRefreshTimeThreshold = 60
    
    private let semaphore = DispatchSemaphore(value: 1)
    private let refreshQueue = DispatchQueue.global(qos: .userInitiated)
    
    // MARK: - Instance methods
    
    func resolve(endpoint: Moya.Endpoint, closure: @escaping Moya.MoyaProvider<AnyTarget>.RequestResultClosure) {
        guard let request = try? endpoint.urlRequest() else {
            closure(.failure(MoyaError.requestMapping("")))
            return
        }
    
        
    }
}
