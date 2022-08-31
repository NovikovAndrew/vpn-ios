//
//  Networking.swift
//  Networking
//
//  Created by Alfauser on 04.08.2022.
//

import Moya
import RxSwift
import Utilities

open class Networking: NetworkingType {
    
    // MARK: - Instance peropties
    
    public var requestResolver: PreRequestResolver?
    
    // MARK: - Provate properties
    
    private lazy var moyaProvider: MoyaProvider<AnyTarget> = .init(
        requestClosure: requestResolver?.resolve(endpoint:closure:) ?? MoyaProvider<AnyTarget>.defaultRequestMapping(for:closure:),
        stubClosure: stubClosure,
        session: sessionManager,
        plugins: networkPlugins
    )
    
    private lazy var stubClosure: MoyaProvider<AnyTarget>.StubClosure = { (tgt: AnyTarget) -> Moya.StubBehavior in
        return .never
    }
    
    private lazy var sessionManager: Moya.Session = {
        
        return .init()
    }()
    
    private(set) lazy var networkPlugins: [Moya.PluginType] = [
        
    ]
    
    // MARK: - Object livecycle
    
    required public init() {
        
    }
    
    // MARK: - Instance methods
    
    @discardableResult
    public func loadCodable<DataType: Decodable>(target: AnyTargetConvertible) -> Observable<DataType> {
        Observable.create { [weak self] observer in
            self?.loadCodable(target: target) { (result: ApiResult<DataType>) in
                switch result {
                case .success(let data):
                    observer.onNext(data)
                case .error(let error):
                    observer.onError(error)
                case .failure(let error):
                    observer.onError(NSError(domain: error, code: -1))
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    @discardableResult
    public func loadCodable<DataType: Decodable>(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Cancellable? {
        loadCodable(target: target,
                    convertToSnakeCase: false,
                    progress: nil,
                    completion: completion)
    }
    
    @discardableResult
    public func loadCodable<DataType: Decodable>(
        target: AnyTargetConvertible,
        cancelIfNoInternet: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Cancellable? {
        loadCodable(target: target,
                    convertToSnakeCase: false,
                    progress: nil,
                    cancelIfNoInternet: cancelIfNoInternet,
                    completion: completion)
    }
    
    @discardableResult
    public func loadCodable<DataType>(
        target: AnyTargetConvertible,
        convertToSnakeCase: Bool,
        progress: ProgressBlock?,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Cancellable? where DataType : Decodable {
        loadCodable(target: target,
                    convertToSnakeCase: convertToSnakeCase,
                    progress: nil,
                    cancelIfNoInternet: true,
                    completion: completion)
    }
    
    @discardableResult
    public func loadCodable<DataType: Decodable>(
        target: AnyTargetConvertible,
        convertToSnakeCase: Bool,
        progress: ProgressBlock?,
        cancelIfNoInternet: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Cancellable? {
        
        let decoder = JSONDecoder()
        if convertToSnakeCase {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        }
        
        return moyaProvider.request(target.any,
                                    callbackQueue: .main,
                                    progress: progress) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonData = try decoder.decode(DataType.self, from: response.data)
                    completion(.success(jsonData))
                } catch {
                    printDEBUG(error)
                    // VPNLocalce.Common.Error.any
                    completion(.failure("Error"))
                }
            case .failure(let error):
                if let errorText = Networking.buildErrorText(moyaError: error) {
                    completion(.failure(errorText))
                }
            }
        }
    }
    
    //
    //    public func load<DataType>(target: AnyTargetConvertible, completion: @escaping (ApiResult<DataType>) -> Void) -> Cancellable? where DataType : Decodable {
    //
    //    }
    //
    //    public func load<DataType>(target: AnyTargetConvertible, cancelIfNoInternet: Bool, completion: @escaping (ApiResult<DataType>) -> Void) -> Cancellable? where DataType : Decodable {
    //
    //    }
    //
    //    public func loadCompletable(target: AnyTargetConvertible, completion: @escaping (ApiResult<Void>) -> Void) {
    //
    //    }
    //
    //    public func loadCompletableCheckStatusCode(target: AnyTargetConvertible, statusCode: HTTPStatusCode, completion: @escaping (ApiResult<Void>) -> Void) {
    //
    //    }
    //
    //    public func loadPayment(target: AnyTargetConvertible, completion: @escaping (ApiResult<[String : Any]>) -> Void) {
    //
    //    }
    //
    //    public func loadDataRespModel<DataType>(target: AnyTargetConvertible, completion: @escaping (ApiResult<DataType>) -> Void) {
    //
    //    }
    //
    
    //    public func loadArray<DataType>(target: AnyTargetConvertible, completion: @escaping (ApiResult<[DataType]>) -> Void) where DataType : Decodable {
    //
    //    }
    //
    //    public func loadString(target: AnyTargetConvertible, completion: @escaping (ApiResult<String>) -> Void) {
    //
    //    }
    //
    //    public func loadDict(target: AnyTargetConvertible, completion: @escaping (ApiResult<[String : Any]>) -> Void) {
    //
    //    }
    //
    //    public func load<Response>(target: AnyTargetConvertible) -> Observable<Response> where Response : Decodable {
    //
    //    }
    //
    //    public func load(target: AnyTargetConvertible) -> Observable<Void> {
    //
    //    }
    //
    //
    //    public func loadCodableWithCustomError<DataType>(target: AnyTargetConvertible, completion: @escaping (ApiResult<DataType>) -> Void) -> Cancellable? where DataType : Decodable {
    //
    //    }
    //
    //    public func loadCodableWithCheckStatusCode<DataType>(
    //        target: AnyTargetConvertible,
    //        statusCode: HTTPStatusCode,
    //        completion: @escaping (ApiResult<DataType>) -> Void
    //    ) -> Cancellable? where DataType : Decodable {
    //
    //    }
    //
    //    public func loadCodableWithCustomError<DataType>(
    //        target: AnyTargetConvertible,
    //        convertToSnakeCase: Bool,
    //        completion: @escaping (ApiResult<DataType>) -> Void)
    //    -> Cancellable? where DataType : Decodable {
    //
    //    }
    //
    //    public func loadCodableWithCustomError<DataType: Decodable>(
    //        target: AnyTargetConvertible, convertToSnakeCase: Bool,
    //        cancelIfNoInternet: Bool,
    //        completion: @escaping (ApiResult<DataType>
    //        ) -> Void) -> Cancellable? {
    //
}


// MARK: - Private methods

extension Networking {
    fileprivate static func buildErrorText(moyaError error: MoyaError) -> String? {
        return ""
    }
}
