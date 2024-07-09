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
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = [
            Station.station1,
            Station.station2
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
        let status = StationStatus(stationId: "1", bikeCount: 4, dockCount: 5)
        let station = Station(station_id: "1", name: "Station Jerozolimska", address: "Jerozolimska 1", lat: 1.0, lon: 11.0, status: status)
        status.station = station
        return station
    }
    static var station2: Station {
        let status = StationStatus(stationId: "2", bikeCount: 3, dockCount: 12)
        let station = Station(station_id: "2", name: "Station Mordor", address: "Mordor 1", lat: 1.0, lon: 11.0, status: status)
        status.station = station
        return station
    }
}

extension ViewModel {
    static var preview: ViewModel {
        let model = ViewModel()
        model.totalStations = 2
        return model
    }
}
