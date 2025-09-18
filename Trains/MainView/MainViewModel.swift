//
//  MainViewModel.swift
//  Trains
//
//  Created by Алексей Непряхин on 15.09.2025.
//

import SwiftUI

@Observable
class MainViewModel {
    let networkClient = NetworkClient()
    
    var isAppDarkMode = UserDefaults.standard.bool(forKey: "isAppDarkMode")
    var fromCity = ""
    var fromStation = ""
    var toCity = ""
    var toStation = ""
    var listOfCarriersViewIsPresenting = false
    var stories: [Story] = [.story1, .story2, .story3]
    
    var isFormValid: Bool {
        !fromCity.isEmpty &&
        !fromStation.isEmpty &&
        !toCity.isEmpty &&
        !toStation.isEmpty
    }
    
    var settlements: [Settlement] = []
    
    let stations: [String] = ["Киевский вокзал",
                                      "Курский вокзал",
                                      "Ярославский вокзал",
                                      "Белорусский вокзал",
                                      "Савеловский вокзал",
                                      "Ленинградский вокзал"]
    
    let carriersInfo: [CarrierInfo] = [CarrierInfo(title: "РЖД",
                                                   logo: "rzdLogo",
                                                   dateDeparture: "14 января",
                                                   timeDeparture: "22:30",
                                                   timeArrival: "8:15",
                                                   estimatedTripTime: "20 часов",
                                                   isWithTransfers: true,
                                                   transfer: "Костроме"),
                                       CarrierInfo(title: "ФГК",
                                                   logo: "fgkLogo",
                                                   dateDeparture: "15 января",
                                                   timeDeparture: "01:15",
                                                   timeArrival: "09:00",
                                                   estimatedTripTime: "9 часов",
                                                   isWithTransfers: false,
                                                   transfer: ""),
                                       CarrierInfo(title: "РЖД2",
                                                   logo: "rzdLogo",
                                                   dateDeparture: "14 января",
                                                   timeDeparture: "22:30",
                                                   timeArrival: "8:15",
                                                   estimatedTripTime: "20 часов",
                                                   isWithTransfers: true,
                                                   transfer: "Костроме"),
                                       
                                       CarrierInfo(title: "ФГК2",
                                                   logo: "fgkLogo",
                                                   dateDeparture: "15 января",
                                                   timeDeparture: "01:15",
                                                   timeArrival: "09:00",
                                                   estimatedTripTime: "9 часов",
                                                   isWithTransfers: false,
                                                   transfer: ""),
                                       CarrierInfo(title: "РЖД3",
                                                   logo: "rzdLogo",
                                                   dateDeparture: "14 января",
                                                   timeDeparture: "22:30",
                                                   timeArrival: "8:15",
                                                   estimatedTripTime: "20 часов",
                                                   isWithTransfers: true,
                                                   transfer: "Костроме"),
                                       
                                       CarrierInfo(title: "ФГК3",
                                                   logo: "fgkLogo",
                                                   dateDeparture: "15 января",
                                                   timeDeparture: "01:15",
                                                   timeArrival: "09:00",
                                                   estimatedTripTime: "9 часов",
                                                   isWithTransfers: false,
                                                   transfer: ""),
                                       CarrierInfo(title: "РЖД4",
                                                   logo: "rzdLogo",
                                                   dateDeparture: "14 января",
                                                   timeDeparture: "22:30",
                                                   timeArrival: "8:15",
                                                   estimatedTripTime: "20 часов",
                                                   isWithTransfers: true,
                                                   transfer: "Костроме"),
                                       
                                       CarrierInfo(title: "ФГК4",
                                                   logo: "fgkLogo",
                                                   dateDeparture: "15 января",
                                                   timeDeparture: "01:15",
                                                   timeArrival: "09:00",
                                                   estimatedTripTime: "9 часов",
                                                   isWithTransfers: false,
                                                   transfer: "")]
    
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
