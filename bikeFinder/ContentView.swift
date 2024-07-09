//
//  ContentView.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 14/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.modelContext) private var modelContext
    @Query private var stations: [Station]

    var body: some View {
        NavigationSplitView {
            List(stations.sorted(by: { $0.name < $1.name })) { station in
                StationCell(station: station)
            }
            .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            .refreshable {
                await SynchronizationManager.startSynchronization(modelContext: modelContext)
            }
        } detail: {
            Text("")
//            StationCell(station: Station.station1)
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
        .environment(ViewModel.preview)
        .modelContainer(PreviewSampleData.container)
}
