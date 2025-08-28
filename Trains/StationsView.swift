//
//  StationsView.swift
//  Trains
//
//  Created by Алексей Непряхин on 21.08.2025.
//

import SwiftUI

struct StationsView: View {
    @Binding var station: String
    @Binding var path: [Route]
    
    @State private var searchText: String = ""
    
    let city: String
    let isFrom: Bool
    
    private let stations: [String] = ["Киевский вокзал",
                                      "Курский вокзал",
                                      "Ярославский вокзал",
                                      "Белорусский вокзал",
                                      "Савеловский вокзал",
                                      "Ленинградский вокзал"]
    
    private var filteredStations: [String] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { $0.localizedCaseInsensitiveContains(searchText) || searchText.localizedStandardContains($0) }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(filteredStations, id: \.self) { station in
                        Button {
                            self.station = station
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

#Preview {
    @Previewable var city: String = ""
    @Previewable @State var station: String = ""
    @Previewable @State var path: [Route] = []
    
    StationsView(station: $station,
                 path: $path,
                 city: city,
                 isFrom: true)
}
