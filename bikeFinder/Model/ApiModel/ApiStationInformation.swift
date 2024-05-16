//
//  ApiStationInformation.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation

struct ApiStationInformation: Decodable {
    var data: Data
    
    struct Data: Decodable {
    var stations: [Stations]
        
        struct Stations: Decodable {
            var station_id: String
            var name: String
            var address: String
            var lat: Double
            var lon: Double
        }
    }
}

extension ApiStationInformation.Data.Stations: CustomStringConvertible {
    var description: String {
    """
    data: {
        stations: {
                station_id: \(station_id),
                name: \(name),
                address: \(address),
                lat: \(lat),
                lon: \(lon)
        }
    }
    """
    }
}

extension ApiStationInformation: CustomStringConvertible {
    var description: String {
        var description = "Empty station information collection."
        if let feature = data.stations.first {
            description = feature.description
            if data.stations.count > 1 {
                description += "\n...and \(data.stations.count - 1) more."
            }
        }
        return description
    }
}
