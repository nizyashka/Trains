//
//  ContentView.swift
//  Trains
//
//  Created by Алексей Непряхин on 29.07.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testFetchStations()
            testFetchCopyright()
            testFetchSearch()
            testFetchSchedule()
            testFetchThread()
            testFetchNearestSettlement()
            testFetchCarrier()
            testFetchStationsList()
        }
    }
    
    func testFetchStations() {
        Task {
            do {
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
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                
                print("Successfully fetched stations: \(stations)")
//                print("Successfully fetched stations.")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func testFetchCopyright() {
        Task {
            do {
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
                
                print("Successfully fetched copyright: \(copyright)")
//                print("Successfully fetched copyright.")
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
    
    func testFetchSearch() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = SearchService(
                    client: client,
                    apikey: Constants.apikey
                )
                
                print("Fetching search...")
                let search = try await service.getScheduleBetweenStations(from: "c146", to: "c213")
                
                print("Successfully fetched search: \(search)")
//                print("Successfully fetched search.")
            } catch {
                print("Error fetching search: \(error)")
            }
        }
    }
    
    func testFetchSchedule() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = ScheduleService(
                    client: client,
                    apikey: Constants.apikey
                )
                
                print("Fetching schedule...")
                let schedule = try await service.getStationSchedule(station: "s9600213")
                
                print("Successfully fetched schedule: \(schedule)")
//                print("Successfully fetched schedule.")
            } catch {
                print("Error fetching schedule: \(error)")
            }
        }
    }
    
    func testFetchThread() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = ThreadService(
                    client: client,
                    apikey: Constants.apikey
                )
                
                print("Fetching thread...")
                let thread = try await service.getRouteStations(uid: "EY-844_250730_c1111_12")
                
                print("Successfully fetched thread: \(thread)")
//                print("Successfully fetched thread.")
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    func testFetchNearestSettlement() {
        Task {
            do {
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
                    lat: 55.7558,
                    lng: 37.6176)
                
                print("Successfully fetched nearest settlement: \(nearestSettlement)")
//                print("Successfully fetched nearest settlement.")
            } catch {
                print("Error fetching nearest settlement: \(error)")
            }
        }
    }
    
    func testFetchCarrier() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = CarrierService(
                    client: client,
                    apikey: Constants.apikey
                )
                
                print("Fetching carrier...")
                let carrier = try await service.getCarrierInfo(code: "26")
                
                print("Successfully fetched carrier: \(carrier)")
//                print("Successfully fetched carrier.")
            } catch {
                print("Error fetching carrier: \(error)")
            }
        }
    }
    
    func testFetchStationsList() {
        Task {
            do {
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
            } catch {
                print("Error fetching all stations: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
