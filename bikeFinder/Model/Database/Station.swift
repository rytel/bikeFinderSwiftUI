//
//  Station.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation
import SwiftData

@Model
struct Station {
    @Attribute(.unique) let station_id: String
    let name: String
    let address: String
    let location: Location
    @Relationship(deleteRule: .cascade) var status: StationStatus?
    
    init(station_id: String, name: String, address: String, lat: Double, lon: Double, status: StationStatus? = nil) {
        self.station_id = station_id
        self.name = name
        self.address = address
        self.location = Location(longitude: lon, latitude: lat)
        self.status = status
    }
}
