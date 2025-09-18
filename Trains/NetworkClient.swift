//
//  FetchMethods.swift
//  Trains
//
//  Created by Алексей Непряхин on 17.09.2025.
//

import OpenAPIURLSession

final class NetworkClient {
    func fetchCities() async -> [Components.Schemas.Settlement] {
        var cities: [Components.Schemas.Settlement] = []
        
        do {
            let stationsList = try await testFetchStationsList()
            
            guard let country = stationsList.countries?.first(where: { $0.title == "Россия" }),
                  let regions = country.regions else {
                assertionFailure("[NetworkClient] - fetchCities: No such country or country has no regions.")
                return cities
            }
            
            for region in regions {
                guard let settlements = region.settlements else {
                    assertionFailure("[NetworkClient] - fetchCities: Region has no settlements.")
                    return cities
                }
                
                cities += settlements
                
//                for settlement in settlements {
//                    guard let settlementTitle = settlement.title else {
//                        assertionFailure("[NetworkClient] - fetchCities: Settlement has no title.")
//                        return cities
//                    }
//                    
//                    cities.append(settlementTitle)
//                }
            }
            
            return cities
        } catch {
            assertionFailure("[NetworkClient] - fetchCities: Received an error while fetching stations list..")
            return cities
        }
    }
    
    func testFetchStationsList() async throws -> StationsList {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = StationsListService(
            client: client,
            apikey: Constants.apikey
        )
        
        print("Fetching all stations...")
        let stationsList = try await service.getAllStations()
        
        //                print("Successfully fetched all stations: \(stationsList)")
        print("Successfully fetched all stations.")
        return stationsList
    }
}
