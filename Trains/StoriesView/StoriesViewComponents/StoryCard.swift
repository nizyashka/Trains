//
//  StoryCard.swift
//  Trains
//
//  Created by Алексей Непряхин on 06.09.2025.
//

import SwiftUI

struct StoryCard: View {
    let backgroundImage: String
    let description: String
    
    var body: some View {
        Image(backgroundImage)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .frame(width: 92, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(content: {
                VStack {
                    Spacer()
                    
                    Text(description)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white)
                        .lineLimit(3)
                }
                .padding(8)
            })
    }
}
