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
    @State private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(viewModel)
        }
        .modelContainer(for: Station.self)
    }
}
