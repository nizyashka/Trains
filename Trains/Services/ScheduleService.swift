//
//  ScheduleService.swift
//  Trains
//
//  Created by Алексей Непряхин on 30.07.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Schedule = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getStationSchedule(station: String) async throws -> Schedule
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationSchedule(station: String) async throws -> Schedule {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station
        ))
        
        return try response.ok.body.json
    }
}
