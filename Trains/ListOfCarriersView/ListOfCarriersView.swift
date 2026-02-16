import SwiftUI

struct ListOfCarriersView: View {
    @State var viewModel: ListOfCarriersViewModel
    @Binding var path: [Route]
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    if let fromCity = viewModel.fromCity,
                       let fromStation = viewModel.fromStation,
                       let toCity = viewModel.toCity,
                       let toStation = viewModel.toStation {
                        Text("\(fromCity.title) (\(fromStation.title)) → \(toCity.title) (\(toStation.title))")
                            .foregroundStyle(Color.accent)
                            .font(.system(size: 24, weight: .bold))
                            .padding()
                    }
                    
                    LazyVStack {
                        ForEach(viewModel.filteredSegments, id: \.id) { segment in
                            ZStack {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color(.lightGrayCarrier))
                                    .frame(height: 104)
                                
                                VStack {
                                    HStack {
                                        AsyncImage(url: URL(string: segment.carrier.logo)!) { result in
                                            result.image?
                                                .resizable()
                                                .scaledToFit()
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .frame(width: 38, height: 38)
                                        
                                        VStack {
                                            HStack {
                                                Text(segment.carrier.title)
                                                    .foregroundStyle(Color.black)
                                                    .font(.system(size: 17))
                                                
                                                Spacer()
                                                
                                                Text(segment.startDate)
                                                    .foregroundStyle(Color.black)
                                                    .font(.system(size: 12))
                                            }
                                            
                                            if segment.hasTransfers {
                                                HStack {
                                                    Text("С пересадкой")
                                                        .font(.system(size: 12))
                                                        .foregroundStyle(.red)
                                                    
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                    
                                    HStack {
                                        Text(segment.departure.toTimeString())
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 17))
                                        
                                        Capsule()
                                            .fill(Color.gray.opacity(0.5))
                                            .frame(height: 2)
                                        
                                        Text(hoursString(for: segment.duration))
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 12))
                                        
                                        Capsule()
                                            .fill(Color.gray.opacity(0.5))
                                            .frame(height: 2)
                                        
                                        Text(segment.arrival.toTimeString())
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 17))
                                    }
                                }
                                .padding()
                            }
                            .padding(.horizontal)
                            .onTapGesture {
                                path.append(.carrierCard(carrier: segment.carrier))
                            }
                        }
                    }
                    .padding(.bottom, 68)
                }
                
            }
            
            VStack {
                Spacer()
                
                Button {
                    path.append(.filters)
                } label: {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.blueRectangle)
                        )
                }
                .padding(.horizontal)
                .background(.clear)
            }
            
            VStack {
                Spacer()
                
                Text(viewModel.segments.isEmpty ? "Вариантов нет" : "")
                    .foregroundStyle(Color.accent)
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                
                Spacer()
            }
        }
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
        .task {
            await viewModel.loadSegments()
        }
    }
    
    func hoursString(for value: Int) -> String {
        let lastTwo = value % 100
        let lastOne = value % 10
        
        if lastTwo >= 11 && lastTwo <= 14 {
            return "\(value) часов"
        }
        
        switch lastOne {
        case 1:
            return "\(value) час"
        case 2...4:
            return "\(value) часа"
        default:
            return "\(value) часов"
        }
    }
}
