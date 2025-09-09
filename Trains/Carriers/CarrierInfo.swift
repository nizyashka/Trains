//
//  Carrier.swift
//  Trains
//
//  Created by Алексей Непряхин on 26.08.2025.
//

import Foundation

struct CarrierInfo: Hashable {
    let title: String
    let logo: String
    let dateDeparture: String
    let timeDeparture: String
    let timeArrival: String
    let estimatedTripTime: String
    let isWithTransfers: Bool
    let transfer: String
}
