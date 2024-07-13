//
//  PreviewSampleData.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import SwiftData
import SwiftUI

/// An actor that provides an in-memory model container for previews.
actor PreviewSampleData {
    @MainActor
    static var container: ModelContainer = {
        return try! inMemoryContainer()
    }()

    static var inMemoryContainer: () throws -> ModelContainer = {
        let schema = Schema([Station.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
//        container.deleteAllData()
        let sampleData: [any PersistentModel] = [
            Station.station1, Station.station2
        ]
        Task { @MainActor in
            sampleData.forEach {
                container.mainContext.insert($0)
            }
        }
        return container
    }
}

// Default stations for use in previews.
extension Station {
    static var station1: Station {
        let station = Station(station_id: "1", name: "Station Jerozolimska 1", address: "St. Jerozolimska 123", lat: 1.0, lon: 11.0, status: StationStatus(bikeCount: 4, dockCount: 5))
        return station
    }
    static var station2: Station {
        let station = Station(station_id: "2", name: "Station Big funny street", address: "Big funny street 321", lat: 2.0, lon: 13.0, status: StationStatus(bikeCount: 1, dockCount: 11))
        return station
    }
}
