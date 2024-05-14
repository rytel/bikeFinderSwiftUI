//
//  StationStatus.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import Foundation
import SwiftData

@Model
struct StationStatus {
    @Attribute(.unique) let stationId: String
    var bikeCount: Int
    var dockCount: Int
    
    init(stationId: String, bikeCount: Int, dockCount: Int) {
        self.stationId = stationId
        self.bikeCount = bikeCount
        self.dockCount = dockCount
    }
}
