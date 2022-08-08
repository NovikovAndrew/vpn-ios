//
//  BaseProviderType.swift
//  Networking
//
//  Created by Alfauser on 08.08.2022.
//

import Moya
import Utilities
import Foundation

public protocol BaseProviderType: TargetType {
    var apiDomain: String { get }
    var timeout: TimeInterval { get }
    var buildApiErrorModelOnServerError: Bool { get }
}


// MARK: - Target type field

public extension BaseProviderType {
    var baseURL: URL {
        getBaseUrl()
    }

    var path: String {
        String()
    }
    
    var apiDomain: String {
        String()
    }
    
    var method: Moya.Method {
        .post
    }
    
    var timeout: TimeInterval {
        120
    }
    
    var sampleData: Data {
        "{}".data(using: .utf8)!
    }
    
    var headers: [String : String]? {
        return getHeaderBuilder().build()
    }
    
    var validationType: ValidationType {
        .customCodes(Array(0..<700))
    }
    
    var ecoding: ParameterEncoding {
        switch self.method {
        case .post, .patch, .put:
            return JSONEncoding.default
        default:
           return URLEncoding.default
        }
    }
}


// MARK: - Target type configuration methods

private extension BaseProviderType {
    func getBaseUrl() -> URL {
        #if TEST
        guard let baseUrlString = injector?.inject(VPNConfigTypes.Type).get(key: .baseUrlApi) else {
            return URL(string: "http://localhost:1234/")!
        }
        
        #else
        guard let baseUrlString = injector?.inject(VPNConfigTypes.self).get(key: .baseUrlApi) else {
            return URL(string: "http://localhost:1234/")!
        }
        
        #endif
        
        return URL(string: baseUrlString)!.appendingPathComponent(apiDomain)
    }
    
    func getHeaderBuilder() -> HttpHeadersBuilderProtocol {
        injector.inject(HttpHeadersBuilderProtocol.self)
    }
}
