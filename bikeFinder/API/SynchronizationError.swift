//
//  SynchronizationError.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 09/07/2024.
//

import Foundation

enum SynchronizationError: LocalizedError {
    case corruptedData
    
    var errorDescription: String {
        switch self {
        case .corruptedData:
            "Some of synchronized data are missing."
        }
    }
}