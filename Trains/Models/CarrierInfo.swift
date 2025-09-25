//
//  Carrier.swift
//  Trains
//
//  Created by Алексей Непряхин on 26.08.2025.
//

import Foundation

struct CarrierInfo: Identifiable, Hashable, Sendable {
    let id: Int
    let title: String
    let phone: String
    let logo: String
    let email: String
}
