//
//  Station.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation
import SwiftData

@Model
class Station {
    @Attribute(.unique) let station_id: String
    let name: String
    let address: String
    let location: Location
    @Relationship(deleteRule: .cascade) var status: StationStatus
    
    init(station_id: String, name: String, address: String, lat: Double, lon: Double, status: StationStatus) {
        self.station_id = station_id
        self.name = name
        self.address = address
        self.location = Location(longitude: lon, latitude: lat)
        self.status = status
    }
    
    init(information: ApiStationInformation.Data.Stations, status: ApiStationStatus.Data.Stations) {
        self.station_id = information.station_id
        self.name = information.name
        self.address = information.address
        self.location = Location(longitude: information.lon, latitude: information.lat)
        self.status = StationStatus(status: status)
    }
}

// A convenience for accessing a station in an array by its identifier.
extension Array where Element: Station {
    /// Gets the first station in the array with the specified ID, if any.
    subscript(id: Station.ID?) -> Station? {
        first { $0.id == id }
    }
}

// Values that the app uses to represent statuses
extension Station {
    var bikeCount: String {
        String(status.bikeCount)
    }
    
    var dockCount: String {
        String(status.dockCount)
    }
}

// A string represenation of the station.
extension Station: CustomStringConvertible {
    var description: String {
        "\(name) \(address) \(location)"
    }
}

extension Station {
    /// A filter that checks for a text in the station's name or adress.
    static func predicate(
        searchText: String
    ) -> Predicate<Station> {
        return #Predicate<Station> { station in
            searchText.isEmpty
            || station.name.contains(searchText)
            || station.address.contains(searchText)
        }
    }

    /// Reports the total number of stations.
    static func totalStations(modelContext: ModelContext) -> Int {
        (try? modelContext.fetchCount(FetchDescriptor<Station>())) ?? 0
    }
}

// Ensure that the model's conformance to Identifiable is public.
extension Station: Identifiable {}
