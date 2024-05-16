//
//  UrlFactory.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation

struct UrlFactory {
    static func buildUrl(baseUrl: URL, path: ApiEndpointPath) -> URL {
        baseUrl.appendingPathComponent(path.rawValue)
    }
}

enum ApiEndpointPath: String {
    case stationInformation = "/station_information.json"
    case stationStatus = "/station_status.json"
}
