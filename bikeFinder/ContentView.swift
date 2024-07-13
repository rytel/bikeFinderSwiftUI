//
//  ContentView.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var stations: [Station]

    var body: some View {
        NavigationSplitView {
            List(stations.sorted(by: { $0.name < $1.name })) { station in
                Text(station.name)
            }
            .refreshable {
                await SynchronizationManager.startSynchronization(modelContext: modelContext)
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(stations[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewSampleData.container)
}
