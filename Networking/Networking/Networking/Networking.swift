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
                    // FIXME: VPNLocalce.Common.Error.any
                    completion(.failure("Error"))
                }
            case .failure(let error):
                if let errorText = Networking.buildErrorText(moyaError: error) {
                    completion(.failure(errorText))
                }
            }
        }
    }
    
    public func load<DataType: Decodable>(target: AnyTargetConvertible, completion: @escaping (ApiResult<DataType>) -> Void) -> Cancellable? {
        fatalError()
    }
    
    public func load<DataType>(target: AnyTargetConvertible, cancelIfNoInternet: Bool, completion: @escaping (ApiResult<DataType>) -> Void) -> Cancellable? where DataType : Decodable {
        fatalError()
    }
    
    public func loadCompletable(target: AnyTargetConvertible, completion: @escaping (ApiResult<Void>) -> Void) {
        fatalError()
    }
    
    public func loadCompletableCheckStatusCode(target: AnyTargetConvertible, statusCode: HTTPStatusCode, completion: @escaping (ApiResult<Void>) -> Void) {
        fatalError()
    }
    
    public func loadPayment(target: AnyTargetConvertible, completion: @escaping (ApiResult<[String : Any]>) -> Void) {
        fatalError()
    }
    
    public func loadDataRespModel<DataType>(target: AnyTargetConvertible, completion: @escaping (ApiResult<DataType>) -> Void) {
        fatalError()
    }
    
    public func loadArray<DataType: Decodable>(target: AnyTargetConvertible, completion: @escaping (ApiResult<[DataType]>) -> Void) {
        fatalError()
    }
    
    public func loadString(target: AnyTargetConvertible, completion: @escaping (ApiResult<String>) -> Void) {
        fatalError()
    }
    
    public func loadDict(target: AnyTargetConvertible, completion: @escaping (ApiResult<[String : Any]>) -> Void) {
        fatalError()
    }
    
    public func load<Response: Decodable>(target: AnyTargetConvertible) -> Observable<Response> {
        fatalError()
    }
    
    public func load(target: AnyTargetConvertible) -> Observable<Void> {
        fatalError()
    }

    public func loadCodableWithCheckStatusCode<DataType: Decodable>(target: AnyTargetConvertible, statusCode: HTTPStatusCode, completion: @escaping (ApiResult<DataType>) -> Void) -> Cancellable? {
        fatalError()
    }
    
    public func loadCodableWithCustomError<DataType: Decodable>(
        target: AnyTargetConvertible,
        completion: @escaping (ApiResult<DataType>
        ) -> Void) -> Cancellable? {
        loadCodableWithCustomError(target: target, convertToSnakeCase: false, completion: completion)
    }
    
    public func loadCodableWithCustomError<DataType: Decodable>(
        target: AnyTargetConvertible,
        convertToSnakeCase: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Cancellable? {
        loadCodableWithCustomError(target: target,
                                   convertToSnakeCase: convertToSnakeCase,
                                   cancelIfNoInternet: true,
                                   completion: completion)
    }
    
    public func loadCodableWithCustomError<DataType: Decodable>(
        target: AnyTargetConvertible,
        convertToSnakeCase: Bool,
        cancelIfNoInternet: Bool,
        completion: @escaping (ApiResult<DataType>) -> Void
    ) -> Cancellable? {
        
        let decoder = JSONDecoder()
        if convertToSnakeCase {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        }

        return moyaProvider.request(target.any) { result in
            switch result {
            case .success(let response):
                let httpStatus = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.internalServerError
                switch httpStatus.responseType {
                case .success:
                    do {
                        let jsonData = try decoder.decode(DataType.self, from: response.data)
                        completion(.success(jsonData))
                    } catch {
                        printDEBUG(error)
                        // FIXME: VPNLocalce.Common.Error.any
                        completion(.failure("Error"))
                    }

                default: break
                }
            case .failure(let error):
                if let errorText = Networking.buildErrorText(moyaError: error) {
                    completion(.failure(errorText))
                }
            }
        }
    }
}


// MARK: - Private methods

extension Networking {
    fileprivate static func buildErrorText(moyaError error: MoyaError) -> String? {
        return ""
    }
}
