//
//  ApiError.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 09/07/2024.
//

import Foundation

/// The kinds of errors that occur when loading data.
enum ApiError: LocalizedError {
    case wrongDataFormat(error: Error)
    case badResponse
    
    var errorDescription: String {
        switch self {
        case .wrongDataFormat(let error):
            "Data format is different than expected, \(error)"
        case .badResponse:
            "Bad response"
        }
    }
}
