import Foundation

struct Settlement: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let stations: [Station]
}
