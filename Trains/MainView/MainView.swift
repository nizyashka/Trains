//
//  MainView.swift
//  Trains
//
//  Created by Алексей Непряхин on 15.08.2025.
//

import SwiftUI

enum Route: Hashable {
    case cities(isFrom: Bool)
    case stations(city: String, isFrom: Bool)
    case carriers
    case carrierCard
    case filters
    case stories(firstToOpen: Story)
}

struct MainView: View {
    @State var viewModel = MainViewModel()
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                StoryCardsView(viewModel: $viewModel, path: $path)
                
                AToBView(viewModel: $viewModel, path: $path)
                
                if viewModel.isFormValid {
                    Button {
                        path.append(.carriers)
                        viewModel.listOfCarriersViewIsPresenting.toggle()
                    } label: {
                        Text("Найти")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 150, height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.blueRectangle)
                            )
                    }
                }
                
                Spacer()
            }
            .background(Color.background)
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .cities(let isFrom):
                    CitiesView(viewModel: $viewModel,
                               path: $path,
                               isFrom: isFrom)
                case .stations(let city, let isFrom):
                    StationsView(path: $path,
                                 viewModel: $viewModel,
                                 city: city,
                                 isFrom: isFrom)
                case .carriers:
                    ListOfCarriersView(path: $path, viewModel: $viewModel)
                case .carrierCard:
                    CarrierCardView(path: $path)
                case .filters:
                    FiltersView(path: $path)
                case .stories(firstToOpen: let firstStory):
                    if let index = viewModel.stories.firstIndex(of: firstStory) {
                        StoriesView(startStoryIndex: index, path: $path, viewModel: $viewModel)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
