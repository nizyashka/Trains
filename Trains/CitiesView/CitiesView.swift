//
//  CitiesView.swift
//  Trains
//
//  Created by Алексей Непряхин on 18.08.2025.
//

import SwiftUI

struct CitiesView: View {
    @Binding var viewModel: MainViewModel
    @Binding var path: [Route]
    
    @State private var searchText: String = ""
    
    let isFrom: Bool
    
    private var filteredCities: [Settlement] {
        guard !searchText.isEmpty else { return viewModel.settlements }
        return viewModel.settlements.filter { $0.title.localizedCaseInsensitiveContains(searchText) || searchText.localizedStandardContains($0.title) }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(filteredCities) { city in
                        Button {
                            if isFrom {
                                viewModel.fromCity = city.title
                            } else {
                                viewModel.toCity = city.title
                            }
                            
                            path.append(.stations(city: city.title, isFrom: isFrom))
                        } label: {
                            HStack {
                                Text(city.title)
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
        .task {
            await viewModel.loadSettlements()
        }
    }
}

//#Preview {
//    @Previewable @State var city: String = ""
//    @Previewable @State var station: String = ""
//    @Previewable @State var path: [Route] = []
//    
//    CitiesView(
//        viewModel: CitiesViewModel(city: city, station: station),
//        path: $path,
//        isFrom: true)
//}
