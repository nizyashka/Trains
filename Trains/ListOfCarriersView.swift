//
//  ListOfCarriersView.swift
//  Trains
//
//  Created by Алексей Непряхин on 21.08.2025.
//

import SwiftUI

struct ListOfCarriersView: View {
    @Binding var fromCity: String
    @Binding var fromStation: String
    @Binding var toCity: String
    @Binding var toStation: String
    @Binding var path: [Route]
    
    let carriersInfo: [CarrierInfo] = [CarrierInfo(title: "РЖД",
                                                   logo: "rzdLogo",
                                                   dateDeparture: "14 января",
                                                   timeDeparture: "22:30",
                                                   timeArrival: "8:15",
                                                   estimatedTripTime: "20 часов",
                                                   isWithTransfers: true,
                                                   transfer: "Костроме"),
                                       
                                       CarrierInfo(title: "ФГК",
                                                   logo: "fgkLogo",
                                                   dateDeparture: "15 января",
                                                   timeDeparture: "01:15",
                                                   timeArrival: "09:00",
                                                   estimatedTripTime: "9 часов",
                                                   isWithTransfers: false,
                                                   transfer: ""),
                                       CarrierInfo(title: "РЖД2",
                                                   logo: "rzdLogo",
                                                   dateDeparture: "14 января",
                                                   timeDeparture: "22:30",
                                                   timeArrival: "8:15",
                                                   estimatedTripTime: "20 часов",
                                                   isWithTransfers: true,
                                                   transfer: "Костроме"),
                                       
                                       CarrierInfo(title: "ФГК2",
                                                   logo: "fgkLogo",
                                                   dateDeparture: "15 января",
                                                   timeDeparture: "01:15",
                                                   timeArrival: "09:00",
                                                   estimatedTripTime: "9 часов",
                                                   isWithTransfers: false,
                                                   transfer: ""),
                                       CarrierInfo(title: "РЖД3",
                                                   logo: "rzdLogo",
                                                   dateDeparture: "14 января",
                                                   timeDeparture: "22:30",
                                                   timeArrival: "8:15",
                                                   estimatedTripTime: "20 часов",
                                                   isWithTransfers: true,
                                                   transfer: "Костроме"),
                                       
                                       CarrierInfo(title: "ФГК3",
                                                   logo: "fgkLogo",
                                                   dateDeparture: "15 января",
                                                   timeDeparture: "01:15",
                                                   timeArrival: "09:00",
                                                   estimatedTripTime: "9 часов",
                                                   isWithTransfers: false,
                                                   transfer: ""),
                                       CarrierInfo(title: "РЖД4",
                                                   logo: "rzdLogo",
                                                   dateDeparture: "14 января",
                                                   timeDeparture: "22:30",
                                                   timeArrival: "8:15",
                                                   estimatedTripTime: "20 часов",
                                                   isWithTransfers: true,
                                                   transfer: "Костроме"),
                                       
                                       CarrierInfo(title: "ФГК4",
                                                   logo: "fgkLogo",
                                                   dateDeparture: "15 января",
                                                   timeDeparture: "01:15",
                                                   timeArrival: "09:00",
                                                   estimatedTripTime: "9 часов",
                                                   isWithTransfers: false,
                                                   transfer: "")]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    Text("\(fromCity) (\(fromStation)) → \(toCity) (\(toStation))")
                        .foregroundStyle(Color.accent)
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                    
                    LazyVStack {
                        ForEach(carriersInfo, id: \.self) { carrier in
                            ZStack {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color(.lightGrayCarrier))
                                    .frame(height: 104)
                                
                                VStack {
                                    HStack {
                                        Image(carrier.logo)
                                            .resizable()
                                            .frame(width: 38, height: 38)
                                        
                                        VStack {
                                            HStack {
                                                Text(carrier.title)
                                                    .foregroundStyle(Color.black)
                                                    .font(.system(size: 17))
                                                
                                                Spacer()
                                                
                                                Text(carrier.dateDeparture)
                                                    .foregroundStyle(Color.black)
                                                    .font(.system(size: 12))
                                            }
                                            
                                            if carrier.isWithTransfers {
                                                HStack {
                                                    Text("С пересадкой в \(carrier.transfer)")
                                                        .font(.system(size: 12))
                                                        .foregroundStyle(.red)
                                                    
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                    
                                    HStack {
                                        Text(carrier.timeDeparture)
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 17))
                                        
                                        Capsule()
                                            .fill(Color.gray.opacity(0.5))
                                            .frame(height: 2)
                                        
                                        Text(carrier.estimatedTripTime)
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 12))
                                        
                                        Capsule()
                                            .fill(Color.gray.opacity(0.5))
                                            .frame(height: 2)
                                        
                                        Text(carrier.timeArrival)
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 17))
                                    }
                                }
                                .padding()
                            }
                            .padding(.horizontal)
                            .onTapGesture {
                                path.append(.carrierCard)
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
                
                Text(carriersInfo.isEmpty ? "Вариантов нет" : "")
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
    }
}

#Preview {
    @Previewable @State var fromCity: String = ""
    @Previewable @State var fromStation: String = ""
    @Previewable @State var toCity: String = ""
    @Previewable @State var toStation: String = ""
    @Previewable @State var path: [Route] = []
    
    ListOfCarriersView(
        fromCity: $fromCity,
        fromStation: $fromStation,
        toCity: $toCity,
        toStation: $toStation,
        path: $path)
}
