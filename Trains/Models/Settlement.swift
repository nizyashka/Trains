//
//  Settlement.swift
//  Trains
//
//  Created by Алексей Непряхин on 17.09.2025.
//

import Foundation

struct Settlement: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let stations: [Station]
}
