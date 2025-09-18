//
//  StationsView.swift
//  Trains
//
//  Created by Алексей Непряхин on 21.08.2025.
//

import SwiftUI

struct StationsView: View {
    @Binding var path: [Route]
    @Binding var viewModel: MainViewModel
    
    @State private var searchText: String = ""
    
    let city: String
    let isFrom: Bool
    
    private var filteredStations: [String] {
        guard !searchText.isEmpty else { return viewModel.stations }
        return viewModel.stations.filter { $0.localizedCaseInsensitiveContains(searchText) || searchText.localizedStandardContains($0) }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(filteredStations, id: \.self) { station in
                        Button {
                            if isFrom {
                                viewModel.fromStation = station
                            } else {
                                viewModel.toStation = station
                            }
                            
                            path = []
                        } label: {
                            HStack {
                                Text(station)
                                    .font(.system(size: 17))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(Color.accent)
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Выбор станции")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        path.removeLast()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.accent)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Введите запрос")
            
            VStack {
                Spacer()
                
                Text(filteredStations.isEmpty ? "Станция не найдена" : "")
                    .foregroundStyle(Color.accent)
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                
                Spacer()
            }
        }
        .background(Color.background)
    }
}
