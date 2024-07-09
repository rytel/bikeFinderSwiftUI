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
            Station.station1
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
        let station = Station(station_id: "1", name: "Name", address: "address", lat: 1.0, lon: 11.0, status: status)
        status.station = station
        return station
    }
}

extension ViewModel {
    static var preview: ViewModel {
        let model = ViewModel()
        model.totalStations = 1
        return model
    }
}
