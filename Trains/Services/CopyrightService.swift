//
//  Copyright.swift
//  Trains
//
//  Created by Алексей Непряхин on 29.07.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.Copyrights

protocol CopyrightServiceProtocol {
    func getCopyright(format: String) async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyright(format: String) async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey,
            format: format
        ))
        
        return try response.ok.body.json
    }
}
