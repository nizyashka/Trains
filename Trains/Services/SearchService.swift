//
//  SearchService.swift
//  Trains
//
//  Created by Алексей Непряхин on 30.07.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Search = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> Search
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> Search {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))
        
        return try response.ok.body.json
    }
}
