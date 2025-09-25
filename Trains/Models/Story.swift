import SwiftUI

struct Story: Identifiable, Hashable {
    let id: UUID
    let backgroundImage: String
    let title: String
    let description: String
    var isViewed: Bool

    static let story1 = Story(
        id: UUID(),
        backgroundImage: "Story1",
        title: "🎉 ⭐️ ❤️",
        description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 ",
        isViewed: false
    )

    static let story2 = Story(
        id: UUID(),
        backgroundImage: "Story2",
        title: "😍 🌸 🥬",
        description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 ",
        isViewed: false
    )

    static let story3 = Story(
        id: UUID(),
        backgroundImage: "Story3",
        title: "🧀 🥑 🥚",
        description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 ",
        isViewed: false
    )
}
