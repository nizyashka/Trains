//
//  ListOfCarriersView.swift
//  Trains
//
//  Created by Алексей Непряхин on 21.08.2025.
//

import SwiftUI

struct ListOfCarriersView: View {
    @Binding var path: [Route]
    @Binding var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    Text("\(viewModel.fromCity) (\(viewModel.fromStation)) → \(viewModel.toCity) (\(viewModel.toStation))")
                        .foregroundStyle(Color.accent)
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                    
                    LazyVStack {
                        ForEach(viewModel.carriersInfo, id: \.self) { carrier in
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
                
                Text(viewModel.carriersInfo.isEmpty ? "Вариантов нет" : "")
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
