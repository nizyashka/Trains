import Foundation

struct Segment: Identifiable, Hashable, Sendable {
    let id = UUID()
    let departure: Date
    let arrival: Date
    let duration: Int
    let startDate: String
    let hasTransfers: Bool
    let carrier: CarrierInfo
}
