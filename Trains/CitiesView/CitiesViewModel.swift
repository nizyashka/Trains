import SwiftUI

@MainActor
@Observable
final class CitiesViewModel {
    let isFrom: Bool
    
    var settlements: [Settlement] = []
    
    private let networkClient = NetworkClient()
    
    init(isFrom: Bool) {
        self.isFrom = isFrom
    }
    
    func loadSettlements() async {
        var newSettlements: [Settlement] = []
        
        let settlements = await networkClient.fetchCities()
        
        for settlement in settlements {
            guard let id = settlement.codes?.yandex_code,
                  let title = settlement.title,
                  let stations = settlement.stations else {
                print("[MainViewModel] - loadSettlements: Error getting id, title or stations of a settlement.")
                continue
            }
            
            var newStations: [Station] = []
            
            for station in stations {
                guard let id = station.codes?.yandex_code,
                      let title = station.title else {
                    print("[MainViewModel] - loadSettlements: Error getting id or title of a station.")
                    continue
                }
                
                let newStation = Station(id: id, title: title)
                newStations.append(newStation)
            }
            
            let newSettlement = Settlement(id: id, title: title, stations: newStations)
            
            newSettlements.append(newSettlement)
        }
        
        self.settlements = newSettlements
    }
}
