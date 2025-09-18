//
//  StoryCardsView.swift
//  Trains
//
//  Created by Алексей Непряхин on 16.09.2025.
//

import SwiftUI

struct StoryCardsView: View {
    @Binding var viewModel: MainViewModel
    @Binding var path: [Route]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem()], spacing: 12) {
                ForEach(viewModel.stories.indices) { index in
                    StoryCard(backgroundImage: viewModel.stories[index].backgroundImage, description: viewModel.stories[index].description)
                        .overlay(setOverlay(isViewed: viewModel.stories[index].isViewed))
                        .onTapGesture {
                            viewModel.stories[index].isViewed = true
                            path.append(.stories(firstToOpen: viewModel.stories[index]))
                        }
                }
            }
            .frame(height: 140)
            .padding(16)
        }
    }
    
    private func setOverlay(isViewed: Bool) -> AnyView {
        if isViewed {
            return AnyView (RoundedRectangle(cornerRadius: 16)
                .fill((viewModel.isAppDarkMode ? Color.gray : Color.white).opacity(0.5)))
        } else {
            return AnyView (RoundedRectangle(cornerRadius: 16)
                .stroke(.blue, lineWidth: 4))
        }
    }
}
