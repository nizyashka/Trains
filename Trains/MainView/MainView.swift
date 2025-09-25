//
//  MainView.swift
//  Trains
//
//  Created by Алексей Непряхин on 15.08.2025.
//

import SwiftUI

enum Route: Hashable {
    case cities(isFrom: Bool)
    case stations(stations: [Station], isFrom: Bool)
    case carriers
    case carrierCard(carrier: CarrierInfo)
    case filters
    case stories(firstToOpen: Story)
}

struct MainView: View {
    @State var viewModel = MainViewModel()
    @State private var path: [Route] = []
    @State var checks = Checks(isCheckedMorning: false,
                               isCheckedDay: false,
                               isCheckedEvening: false,
                               isCheckedNight: false,
                               isCheckedYes: true,
                               isCheckedNo: false)
    
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
                    let citiesViewModel = CitiesViewModel(isFrom: isFrom)
                    CitiesView(viewModel: citiesViewModel, path: $path, city: isFrom ? $viewModel.fromCity : $viewModel.toCity)
                    
                case .stations(let stations, let isFrom):
                    let stationsViewModel = StationsViewModel(stations: stations)
                    StationsView(viewModel: stationsViewModel, path: $path, station: isFrom ? $viewModel.fromStation : $viewModel.toStation)
                    
                case .carriers:
                    let listOfCarriersViewModel = ListOfCarriersViewModel(fromCity: viewModel.fromCity, fromStation: viewModel.fromStation, toCity: viewModel.toCity, toStation: viewModel.toStation, checks: $checks)
                    
                    ListOfCarriersView(viewModel: listOfCarriersViewModel, path: $path)
                    
                case .carrierCard(let carrier):
                    CarrierCardView(path: $path, carrier: carrier)
                    
                case .filters:
                    FiltersView(checks: $checks, path: $path)
                    
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
