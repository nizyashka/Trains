import SwiftUI

struct CitiesView: View {
    @State var viewModel: CitiesViewModel
    @Binding var path: [Route]
    @Binding var city: Settlement?
    
    @State private var searchText: String = ""
    @State var showList: Bool = false
    @State private var isLoading = true
    
    private var filteredCities: [Settlement] {
        guard !searchText.isEmpty else { return viewModel.settlements }
        return viewModel.settlements.filter { $0.title.localizedCaseInsensitiveContains(searchText) || searchText.localizedStandardContains($0.title) }
    }
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("Загружаем города...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundStyle(Color.accent)
                    .font(.system(size: 16, weight: .medium))
            } else {
                ScrollView {
                    CustomSearchBar(text: $searchText)
                    
                    if showList {
                        LazyVStack {
                            ForEach(filteredCities, id: \.id) { city in
                                Button {
                                    self.city = city
                                    searchText = ""
                                    path.append(.stations(stations: city.stations, isFrom: viewModel.isFrom))
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
                }
                
                VStack {
                    Spacer()
                    
                    Text(filteredCities.isEmpty ? "Город не найден" : "")
                        .foregroundStyle(Color.accent)
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            showList = true
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
        .background(Color.background)
        .task {
            await viewModel.loadSettlements()
            isLoading = false
        }
    }
}
