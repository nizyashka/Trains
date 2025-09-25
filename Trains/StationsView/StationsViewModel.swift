//
//  StationsViewModel.swift
//  Trains
//
//  Created by Алексей Непряхин on 19.09.2025.
//

import SwiftUI

@MainActor
@Observable
final class StationsViewModel {
    var stations: [Station]
    
    init(stations: [Station]) {
        self.stations = stations
    }
}
