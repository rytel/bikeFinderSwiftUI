//
//  SynchronizationManager.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 15/05/2024.
//

import Foundation
import OSLog
import SwiftData

class SynchronizationManager {
    fileprivate static let logger = Logger(
        subsystem: "com.rytel.bikeFinder",
        category: String(describing: SynchronizationManager.self)
    )
    
    @MainActor
    static func startSynchronization(modelContext: ModelContext) async {
        await downloadStations(modelContext: modelContext)
    }
    
    @MainActor
    static func downloadStations(modelContext: ModelContext) async {
        do {
            // Fetch the latest set of stations from the server.
            logger.debug("Refreshing the stations...")
            let stationInformation = try await ApiConnector.shared.fetchStationInformation()
            logger.debug("Loaded station information:\n\(stationInformation)")
            let stationStatus = try await ApiConnector.shared.fetchStationStatuses()
            logger.debug("Loaded station status:\n\(stationStatus)")
            
            try modelContext.delete(model: Station.self)
            // Add the content to the data store.
            for station in stationInformation.data.stations {
                guard let status = stationStatus.data.stations.first(where: { $0.stationId == station.station_id })
                else {
                    logger.error("Station status not found")
                    throw SynchronizationError.corruptedData
                }
                let station = Station(information: station, status: status)
                logger.debug("Inserting \(station)")
                modelContext.insert(station)
            }
            logger.debug("Refresh complete.")
            
        } catch let error as LocalizedError {
            logger.error("\(error.errorDescription ?? "Missing error description.")")
            //TODO: Add here error alert for user
            
        } catch let error {
            logger.error("\(error.localizedDescription)")
            //TODO: Add here error alert for user
        }
    }
}
