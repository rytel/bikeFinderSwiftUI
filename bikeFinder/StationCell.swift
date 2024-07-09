//
//  StationCell.swift
//  bikeFinder
//
//  Created by Rafał Rytel on 09/07/2024.
//

import SwiftUI

struct StationCell: View {
    var station: Station
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24.0) {
            Text(station.name)
                .font(.title)
                .multilineTextAlignment(.leading)
                .bold()
            HStack {
                Text("range")
                    .bold()
                Text(station.address)
            }
            HStack {
                StationCellDetails(
                    number: "12",
                    type: .bike)
                StationCellDetails(
                    number: "12",
                    type: .place)
            }
            Spacer()
        }
    }
}

struct StationCellDetails: View {
    var number: String
    var type: ViewType
    var body: some View {
        VStack(spacing: 12.0) {
            Image(systemName: type.imageName)
                .font(.title)
            Text(number)
                .font(.title)
                .foregroundStyle(type.numberColor)
                .bold()
            Text(type.availability)
        }
    }
}

enum ViewType {
    case bike
    case place
    
    var imageName: String {
        switch self {
        case .bike:
            "bicycle"
        case .place:
            "lock.open"
        }
    }
    var availability: String {
        switch self {
        case .bike:
            "bicykles available"
        case .place:
            "places available"
        }
    }
    
    var numberColor: Color {
        switch self {
        case .bike:
            Color.green
        case .place:
            Color.blue
        }
    }
}

#Preview {
//    ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
//        VStack {
            StationCell(station: .station1)
//        }
//        .padding()
//        .frame(minWidth: 300, alignment: .leading)
//    }
}
