//
//  AToBView.swift
//  Trains
//
//  Created by Алексей Непряхин on 16.09.2025.
//

import SwiftUI

struct AToBView: View {
    @Binding var viewModel: MainViewModel
    @Binding var path: [Route]
    
    var body: some View {
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
                            Text(viewModel.fromStation == nil ? "Откуда" : "\(viewModel.fromCity!.title) (\(viewModel.fromStation!.title))")
                                .foregroundColor(viewModel.fromStation == nil ? .gray : .black)
                                .lineLimit(1)
                        }
                        
                        Button {
                            path.append(.cities(isFrom: false))
                        } label: {
                            Text(viewModel.toStation == nil ? "Куда" : "\(viewModel.toCity!.title) (\(viewModel.toStation!.title))")
                                .foregroundColor(viewModel.toStation == nil ? .gray : .black)
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
                        let tempFromCity = viewModel.fromCity
                        let tempFromStation = viewModel.fromStation
                        
                        viewModel.fromCity = viewModel.toCity
                        viewModel.fromStation = viewModel.toStation
                        
                        viewModel.toCity = tempFromCity
                        viewModel.toStation = tempFromStation
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
    }
}
