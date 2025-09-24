//
//  StationsView.swift
//  Trains
//
//  Created by Алексей Непряхин on 21.08.2025.
//

import SwiftUI

struct StationsView: View {
    @State var viewModel: StationsViewModel
    @Binding var path: [Route]
    @Binding var station: Station?
    
    @State private var searchText: String = ""
    @State var showList: Bool = false
    
    private var filteredStations: [Station] {
        guard !searchText.isEmpty else { return viewModel.stations }
        return viewModel.stations.filter { $0.title.localizedCaseInsensitiveContains(searchText) || searchText.localizedStandardContains($0.title) }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                TextField("Введите запрос", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                if showList {
                    LazyVStack {
                        ForEach(filteredStations, id: \.id) { station in
                            Button {
                                self.station = station
                                searchText = ""
                                path = []
                            } label: {
                                HStack {
                                    Text(station.title)
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
            }
            
            VStack {
                Spacer()
                
                Text(filteredStations.isEmpty ? "Станция не найдена" : "")
                    .foregroundStyle(Color.accent)
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                
                Spacer()
            }
        }
        .onAppear {
            showList = true
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
        .background(Color.background)
    }
}
