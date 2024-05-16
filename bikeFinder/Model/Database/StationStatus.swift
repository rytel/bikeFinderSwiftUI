//
//  StationStatus.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation
import SwiftData

@Model
class StationStatus {
    @Attribute(.unique) let stationId: String
    var bikeCount: Int
    var dockCount: Int
    @Relationship var station: Station?

    
    init(stationId: String, bikeCount: Int, dockCount: Int) {
        self.stationId = stationId
        self.bikeCount = bikeCount
        self.dockCount = dockCount
    }
    
    init(status: ApiStationStatus.Data.Stations) {
        self.stationId = status.stationId
        self.bikeCount = status.bikeCount
        self.dockCount = status.dockCount
    }
}
