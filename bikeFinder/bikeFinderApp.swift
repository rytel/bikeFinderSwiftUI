//
//  bikeFinderApp.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import SwiftUI
import SwiftData

@main
struct bikeFinderApp: App {
    let container = try! ModelContainer(for: Station.self)
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Station.self)
    }
}
