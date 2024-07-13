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
    var bikeCount: Int
    var dockCount: Int
    var station: Station?
    
    init(bikeCount: Int, dockCount: Int) {
        self.bikeCount = bikeCount
        self.dockCount = dockCount
    }
    
    init(status: ApiStationStatus.Data.Stations) {
        self.bikeCount = status.bikeCount
        self.dockCount = status.dockCount
    }
}
