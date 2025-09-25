//
//  FetchMethods.swift
//  Trains
//
//  Created by Алексей Непряхин on 17.09.2025.
//

import OpenAPIURLSession

actor NetworkClient {
    func fetchCities() async -> [Components.Schemas.Settlement] {
        var cities: [Components.Schemas.Settlement] = []
        
        do {
            let stationsList = try await fetchStationsList()
            
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
            }
            
            return cities
        } catch {
            print("[NetworkClient] - fetchCities: Received an error while fetching stations list.")
            return cities
        }
    }
    
    func fetchSegments(from stationA: String, to stationB: String) async -> [Components.Schemas.Segment] {
        do {
            print(stationA, stationB)
            
            let search = try await fetchSearch(from: stationA, to: stationB)
            
            guard let segments = search.segments else {
                assertionFailure("[NetworkClient] - fetchSegments: Search has no segments.")
                return []
            }
            
            return segments
        } catch {
            assertionFailure("[NetworkClient] - fetchSegments: Received an error while fetching search.")
            return []
        }
    }
    
    func fetchCopyrightTextAndImage() async -> Components.Schemas.Copyright? {
        do {
            let copyrights = try await fetchCopyright()
            
            guard let copyright = copyrights.copyright else {
                assertionFailure("[NetworkClient] - fetchCopyrightTextAndImage: Copyrights have no copyright.")
                return nil
            }
            
            return copyright
        } catch {
            assertionFailure("[NetworkClient] - fetchCopyrightTextAndImage: Received an error while fetching copyrights.")
            return nil
        }
    }
    
    private func fetchStationsList() async throws -> StationsList {
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
        
        print("Successfully fetched all stations.")
        return stationsList
    }
    
    private func fetchSearch(from stationA: String, to stationB: String) async throws -> Search {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = SearchService(
            client: client,
            apikey: Constants.apikey
        )
        
        print("Fetching search...")
        let search = try await service.getScheduleBetweenStations(from: stationA, to: stationB)
        
        print("Successfully fetched search.")
        return search
    }
    
    private func fetchCopyright() async throws -> Copyright {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(
            client: client,
            apikey: Constants.apikey
        )
        
        print("Fetching copyright...")
        let copyright = try await service.getCopyright(format: "json")
        
        print("Successfully fetched copyright.")
        return copyright
    }
    
    private func testFetchStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: Constants.apikey
        )
        
        print("Fetching stations...")
        let stations = try await service.getNearestStations(
            lat: lat,
            lng: lng,
            distance: distance
        )
        
        print("Successfully fetched stations.")
        return stations
    }
    
    private func testFetchSchedule(station: String) async throws -> Schedule {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = ScheduleService(
            client: client,
            apikey: Constants.apikey
        )
        
        print("Fetching schedule...")
        let schedule = try await service.getStationSchedule(station: station)
        
        print("Successfully fetched schedule.")
        return schedule
    }
    
    private func testFetchThread(uid: String) async throws -> Thread {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = ThreadService(
            client: client,
            apikey: Constants.apikey
        )
        
        print("Fetching thread...")
        let thread = try await service.getRouteStations(uid: uid)
        
        print("Successfully fetched thread.")
        return thread
    }
    
    private func testFetchNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: Constants.apikey
        )
        
        print("Fetching nearest settlement...")
        let nearestSettlement = try await service.getNearestCity(
            lat: lat,
            lng: lng)
        
        print("Successfully fetched nearest settlement.")
        return nearestSettlement
    }
    
    private func testFetchCarrier(code: String) async throws -> Carrier {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = CarrierService(
            client: client,
            apikey: Constants.apikey
        )
        
        print("Fetching carrier...")
        let carrier = try await service.getCarrierInfo(code: code)
        
        print("Successfully fetched carrier.")
        return carrier
    }
}
