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
    @State private var path: [Route] = []
    @Binding var isAppDarkMode: Bool
    
    @State var fromCity = ""
    @State var fromStation = ""
    @State var toCity = ""
    @State var toStation = ""
    @State var listOfCarriersViewIsPresenting = false
    
    @State var stories: [Story] = [.story1, .story2, .story3]
    private let gridItems = [GridItem()]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridItems, spacing: 12) {
                        ForEach(stories.indices) { index in
                            StoryCard(backgroundImage: stories[index].backgroundImage, description: stories[index].description)
                                .overlay(setOverlay(isViewed: stories[index].isViewed))
                                .onTapGesture {
                                    stories[index].isViewed = true
                                    path.append(.stories(firstToOpen: stories[index]))
                                }
                        }
                    }
                    .frame(height: 140)
                    .padding(16)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.blueRectangle)
                        .frame(height: 128)
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .frame(height: 96)
                            
                            VStack(alignment: .leading, spacing: 25) {
                                Button {
                                    path.append(.cities(isFrom: true))
                                } label: {
                                    Text(fromStation.isEmpty ? "Откуда" : "\(fromCity) (\(fromStation))")
                                        .foregroundColor(fromStation.isEmpty ? .gray : .black)
                                        .lineLimit(1)
                                }
                                
                                Button {
                                    path.append(.cities(isFrom: false))
                                } label: {
                                    Text(toStation.isEmpty ? "Куда" : "\(toCity) (\(toStation))")
                                        .foregroundColor(toStation.isEmpty ? .gray : .black)
                                        .lineLimit(1)
                                }
                            }
                            .padding()
                        }
                        .padding(16)
                        
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 36, height: 36)
                            
                            Button {
                                let tempFromCity = fromCity
                                let tempFromStation = fromStation
                                
                                fromCity = toCity
                                fromStation = toStation
                                
                                toCity = tempFromCity
                                toStation = tempFromStation
                            } label: {
                                Image("Change")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .padding(EdgeInsets(top: 16, leading: -8, bottom: 16, trailing: 16))
                    }
                }
                .padding(16)
                
                if isFormValid {
                    Button {
                        path.append(.carriers)
                        listOfCarriersViewIsPresenting.toggle()
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
                    CitiesView(city: isFrom ? $fromCity : $toCity,
                               station: isFrom ? $fromStation : $toStation,
                               path: $path,
                               isFrom: isFrom)
                case .stations(let city, let isFrom):
                    StationsView(station: isFrom ? $fromStation : $toStation,
                                 path: $path,
                                 city: city,
                                 isFrom: isFrom)
                case .carriers:
                    ListOfCarriersView(
                        fromCity: $fromCity,
                        fromStation: $fromStation,
                        toCity: $toCity,
                        toStation: $toStation,
                        path: $path)
                case .carrierCard:
                    CarrierCardView(path: $path)
                case .filters:
                    FiltersView(path: $path)
                case .stories(firstToOpen: let firstStory):
                    if let index = stories.firstIndex(of: firstStory) {
                        StoriesView(stories: $stories, startStoryIndex: index, path: $path)
                    }
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !fromCity.isEmpty &&
        !fromStation.isEmpty &&
        !toCity.isEmpty &&
        !toStation.isEmpty
    }
    
    private func setOverlay(isViewed: Bool) -> AnyView {
        if isViewed {
            return AnyView (RoundedRectangle(cornerRadius: 16)
                .fill((isAppDarkMode ? Color.gray : Color.white).opacity(0.5)))
        } else {
            return AnyView (RoundedRectangle(cornerRadius: 16)
                .stroke(.blue, lineWidth: 4))
        }
    }
}

#Preview {
    @Previewable @State var isAppDarkMode: Bool = false
    
    MainView(isAppDarkMode: $isAppDarkMode)
}
