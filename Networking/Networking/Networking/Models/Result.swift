//
//  Result.swift
//  Networking
//
//  Created by Alfauser on 12.08.2022.
//

public enum ApiResult<DataType> {
    case success(DataType)
    case error(Error)
}
