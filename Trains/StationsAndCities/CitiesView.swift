//
//  CitiesView.swift
//  Trains
//
//  Created by Алексей Непряхин on 18.08.2025.
//

import SwiftUI

struct CitiesView: View {
    @Binding var city: String
    @Binding var station: String
    @Binding var path: [Route]
    
    @State private var searchText: String = ""
    
    let isFrom: Bool
    
    private let cities: [String] = ["Москва",
                                    "Санкт-Петербург",
                                    "Сочи",
                                    "Горный воздух",
                                    "Краснодар",
                                    "Казань",
                                    "Омск"]
    
    private var filteredCities: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.localizedCaseInsensitiveContains(searchText) || searchText.localizedStandardContains($0) }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(filteredCities, id: \.self) { city in
                        Button {
                            self.city = city
                            path.append(.stations(city: city, isFrom: isFrom))
                        } label: {
                            HStack {
                                Text(city)
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
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        path.removeLast()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.accent)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Введите запрос")
            
            VStack {
                Spacer()
                
                Text(filteredCities.isEmpty ? "Город не найден" : "")
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
    @Previewable @State var city: String = ""
    @Previewable @State var station: String = ""
    @Previewable @State var path: [Route] = []
    
    CitiesView(
        city: $city,
        station: $station,
        path: $path,
        isFrom: true)
}
