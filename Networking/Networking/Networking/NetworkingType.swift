//
//  NetworkingType.swift
//  Networking
//
//  Created by Alfauser on 04.08.2022.
//

import Foundation
import Alamofire
import RxSwift
import Moya

public protocol NetworkingType: AnyObject {
    /// Method for networking request with provided Moya target and response object Generic type
    ///
    /// - Parameter target: Moya target to build request with
    /// - Parameter completion: Request completion with ApiResult case
    @discardableResult
    func load<DataType: Decodable>(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    
    @discardableResult
    func load<DataType: Decodable>(
        target: AnyTargetConvertible,
        cancelIfNoInternet: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    /// Designated method for networking request with provided Moya target, where we don't deserialize response into anything
    ///
    /// - Parameter target: Moya target to build request with
    /// - Parameter completion: Request completion with ApiResult case
    func loadCompletable(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<Void>) -> Void
    )
    
    func loadCompletableCheckStatusCode(
        target: AnyTargetConvertible,
        statusCode: HTTPStatusCode,
        completion: @escaping (ApiResult<Void>) -> Void
    )
    /// Designated method for Payment-related networking requests with legacy AlfaClick format (to be deprecated)
    /// - Parameter target: Moya target to build request with
    /// - Parameter completion: Request completion with ApiResult case
    func loadPayment(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<[String: Any]>) -> Void
    )
    /// Method for networking request with legacy response data format `{data: Object, code: Int}`
    /// Data object is deserialized into provided Generic type
    ///
    /// - Parameter target: Moya target to build request with
    /// - Parameter completion: Request completion with ApiResult case
    func loadDataRespModel<DataType>(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<DataType>) -> Void
    )
    
    func loadCodable<DataType: Decodable>(target: AnyTargetConvertible) -> Observable<DataType>
    
    func loadArray<DataType: Decodable>(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<[DataType]>) -> Void
    )
    func loadString(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<String>) -> Void
    )
    func loadDict(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<[String: Any]>) -> Void
    )
    
    func load<Response: Decodable>(
        target: AnyTargetConvertible
    ) -> Observable<Response>
    func load(
        target: AnyTargetConvertible
    ) -> Observable<Void>
    
    // MARK: - Codable
    
    @discardableResult
    func loadCodable<DataType: Decodable>(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    
    @discardableResult
    func loadCodable<DataType: Decodable>(
        target: AnyTargetConvertible,
        cancelIfNoInternet: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    
    @discardableResult
    func loadCodableWithCustomError<DataType: Decodable>(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    
    @discardableResult
    func loadCodableWithCheckStatusCode<DataType: Decodable>(
        target: AnyTargetConvertible,
        statusCode: HTTPStatusCode,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    
    @discardableResult
    func loadCodableWithCustomError<DataType: Decodable>(
        target: AnyTargetConvertible,
        convertToSnakeCase: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    
    @discardableResult
    func loadCodableWithCustomError<DataType: Decodable>(
        target: AnyTargetConvertible,
        convertToSnakeCase: Bool,
        cancelIfNoInternet: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    
    @discardableResult
    func loadCodable<DataType: Decodable>(
        target: AnyTargetConvertible,
        convertToSnakeCase: Bool,
        progress: ProgressBlock?,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
    
    @discardableResult
    func loadCodable<DataType: Decodable>(
        target: AnyTargetConvertible,
        convertToSnakeCase: Bool,
        progress: ProgressBlock?,
        cancelIfNoInternet: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Moya.Cancellable?
}
