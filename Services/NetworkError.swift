//
//  NetworkError.swift
//  TargetAPI
//
//  Created by Isiah Parra on 10/6/22.
//

import Foundation
enum NetworkError: Error, LocalizedError {
    case requestError(Error)
    case badURL
    case couldNotUnwrap
    case errorDecoding(Error)
    
    var localizedDescription: String {
        switch self {
        case .requestError(let error):
            return "Error performing the task: \(error.localizedDescription)"
        case .badURL:
            return "Unable to make the request with the given URL"
        case .couldNotUnwrap:
            return "Error parsing requested data"
        case .errorDecoding:
            return "Error ecountered when decoding the data"
        }
    }
}
