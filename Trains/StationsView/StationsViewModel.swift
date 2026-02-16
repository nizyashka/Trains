import SwiftUI

@MainActor
@Observable
final class StationsViewModel {
    var stations: [Station]
    
    init(stations: [Station]) {
        self.stations = stations
    }
}
