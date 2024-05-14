//
//  Station+API.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 15/05/2024.
//

import SwiftData
import OSLog

// A mapping from items in the ApiStationInformation to station items.
extension Station {
    init(information: ApiStationInformation.Data.Stations, status: ApiStationStatus.Data.Stations) {
        self.station_id = information.station_id
        self.name = information.name
        self.address = information.address
        self.location = Location(longitude: information.lon, latitude: information.lat)
        self.status = StationStatus(status: status)
    }
    
    
}

// Helper methods for loading feature data and storing it as Stations.
extension ApiStationInformation {
    /// A logger for debugging.
    fileprivate static let logger = Logger(
        subsystem: "com.rytel.bikeFinder",
        category: String(describing: ApiStationInformation.self)
    )
    
    /// Loads new earthquakes and deletes outdated ones.
    @MainActor
    static func refresh(modelContext: ModelContext) async {
        do {
            // Fetch the latest set of quakes from the server.
            logger.debug("Refreshing the data store...")
            let featureCollection = try await fetchFeatures()
            logger.debug("Loaded feature collection:\n\(featureCollection)")

            // Add the content to the data store.
            for feature in featureCollection.features {
                let quake = Quake(from: feature)

                // Ignore anything with a magnitude of zero or less.
                if quake.magnitude > 0 {
                    logger.debug("Inserting \(quake)")
                    modelContext.insert(quake)
                }
            }

            logger.debug("Refresh complete.")

        } catch let error {
            logger.error("\(error.localizedDescription)")
        }
    }
}
