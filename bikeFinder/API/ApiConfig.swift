//
//  ApiConfig.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation

struct ApiConfig {
    static let baseUrl: URL = {
        URL(string: "https://gbfs.urbansharing.com/rowermevo.pl")!
    }()
}
