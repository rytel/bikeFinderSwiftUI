//
//  ApiStationStatus.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation

struct ApiStationStatus: Decodable {
    var data: Data
    
    struct Data: Decodable {
        var stations: [Stations]
        
        struct Stations: Decodable {
            let stationId: String
            let bikeCount: Int
            let dockCount: Int
            
            enum CodingKeys: String, CodingKey {
                case stationId = "station_id"
                case bikeCount = "num_bikes_available"
                case dockCount = "num_docks_available"
            }
        }
    }
}

extension ApiStationStatus.Data.Stations: CustomStringConvertible {
    var description: String {
    """
    data: {
        stations: {
            \(stationId.codingKey): \(stationId),
            \(bikeCount.codingKey): \(bikeCount),
            \(dockCount.codingKey): \(dockCount)
        }
    }
    """
    }
}

extension ApiStationStatus: CustomStringConvertible {
    var description: String {
        var description = "Empty station status collection."
        if let feature = data.stations.first {
            description = feature.description
            if data.stations.count > 1 {
                description += "\n...and \(data.stations.count - 1) more."
            }
        }
        return description
    }
}
