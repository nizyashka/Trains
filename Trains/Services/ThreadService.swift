//
//  ThreadService.swift
//  Trains
//
//  Created by Алексей Непряхин on 30.07.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Thread = Components.Schemas.ThreadStationsResponse

protocol ThreadServiceProtocol {
    func getRouteStations(uid: String) async throws -> Thread
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRouteStations(uid: String) async throws -> Thread {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid
        ))
        
        return try response.ok.body.json
    }
}
