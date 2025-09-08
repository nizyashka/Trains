//
//  FiltersView.swift
//  Trains
//
//  Created by Алексей Непряхин on 26.08.2025.
//

import SwiftUI

struct FiltersView: View {
    @State var isCheckedMorning = false
    @State var isCheckedDay = false
    @State var isCheckedEvening = false
    @State var isCheckedNight = false
    @State var isCheckedYes = false
    @State var isCheckedNo = false
    
    @Binding var path: [Route]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 38) {
                    Text("Время отправления")
                        .foregroundStyle(Color.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 24, weight: .bold))
                    
                    CheckBoxView(isChecked: $isCheckedMorning, timeFilterText: "Утро 06:00 - 12:00")
                    CheckBoxView(isChecked: $isCheckedDay, timeFilterText: "День 12:00 - 18:00")
                    CheckBoxView(isChecked: $isCheckedEvening, timeFilterText: "Вечер 18:00 - 00:00")
                    CheckBoxView(isChecked: $isCheckedNight, timeFilterText: "Ночь 00:00 - 06:00")
                    
                    Text("Показывать варианты с пересадками")
                        .foregroundStyle(Color.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 24, weight: .bold))
                    
                    HStack {
                        Text("Да")
                            .foregroundStyle(Color.accent)
                            .font(.system(size: 17, weight: .regular))
                        
                        Spacer()
                        
                        Button(action: {
                            isCheckedYes.toggle()
                        }) {
                            Image(systemName: isCheckedYes ? "record.circle" : "circle")
                                .foregroundStyle(Color.accent)
                                .font(.system(size: 17, weight: .regular))
                        }
                    }
                    
                    HStack {
                        Text("Нет")
                            .foregroundStyle(Color.accent)
                            .font(.system(size: 17, weight: .regular))
                        
                        Spacer()
                        
                        Button(action: {
                            isCheckedNo.toggle()
                        }) {
                            Image(systemName: isCheckedNo ? "record.circle" : "circle")
                                .foregroundStyle(Color.accent)
                                .font(.system(size: 17, weight: .regular))
                        }
                    }
                }
                .padding()
            }
            
            VStack {
                Spacer()
                
                let checks = [isCheckedMorning, isCheckedDay, isCheckedEvening, isCheckedNight, isCheckedYes, isCheckedNo]

                if checks.contains(true) {
                    Button {
                        
                    } label: {
                        Text("Применить")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.blueRectangle)
                            )
                    }
                    .padding(.horizontal)
                }
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
    @Previewable @State var path: [Route] = []
    
    FiltersView(path: $path)
}
