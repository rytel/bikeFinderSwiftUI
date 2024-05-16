//
//  ApiConnector.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation
import OSLog

struct ApiConnector {
    fileprivate let logger = Logger(
        subsystem: "com.rytel.bikeFinder",
        category: String(describing: ApiConnector.self)
    )
    fileprivate let baseUrl = ApiConfig.baseUrl
    static let shared = ApiConnector()
    
    func fetchStationInformation() async throws -> ApiStationInformation {
        try await fetch(path: .stationInformation)
    }
    
    func fetchStationStatuses() async throws -> ApiStationStatus {
        try await fetch(path: .stationStatus)
    }
}

fileprivate extension ApiConnector {
    func fetch<T:Decodable>(path: ApiEndpointPath) async throws -> T {
        let url = dataIfServerDown(path: path)
        let data = try String(contentsOfFile: url.path()).data(using: .utf8)!
//        let url = UrlFactory.buildUrl(baseUrl: baseUrl, path: path)
//        let session = URLSession.shared
//        logger.debug("Start downloading: \(T.self) -> \(url)")
//        guard let (data, response) = try? await session.data(from: url),
//              let httpResponse = response as? HTTPURLResponse,
//              httpResponse.statusCode == 200
//        else {
//            logger.error("Downloading failed: \(T.self) -> \(url)")
//            throw DownloadError.missingData
//        }
        do {
            logger.debug("Downloading success: \(T.self) -> \(url)")
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(T.self, from: data)
            logger.debug("Decoding success: \(T.self) -> \(url)")
            return result
        } catch {
            logger.error("Decoding failed: \(T.self) -> \(url)")
            throw DownloadError.wrongDataFormat(error: error)
        }
    }
    
    func dataIfServerDown(path: ApiEndpointPath) -> URL {
        switch path {
        case .stationInformation:
            Bundle.main.url(forResource: "stationInformation", withExtension: "json")!
        case .stationStatus:
            Bundle.main.url(forResource: "stationStatus", withExtension: "json")!
        }
    }
}

/// The kinds of errors that occur when loading data.
enum DownloadError: Error {
    case wrongDataFormat(error: Error)
    case missingData
}
