//
//  SettingsView.swift
//  Trains
//
//  Created by Алексей Непряхин on 15.08.2025.
//

import SwiftUI

struct SettingsView: View {
    @State var path: [String] = []
    @Binding var isAppDarkMode: Bool
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(isAppDarkMode ? Color.backgroundBlackStatic : .white)
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 38) {
                    Toggle(isOn: $isAppDarkMode) {
                        Text("Темная тема")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(isAppDarkMode ? .white : Color.backgroundBlackStatic)
                    }
                    .tint(.blue)
                    
                    Button {
                        path.append("UserAgreementView")
                    } label: {
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(isAppDarkMode ? .white : Color.backgroundBlackStatic)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(isAppDarkMode ? .white : Color.backgroundBlackStatic)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    
                    Spacer()
                    
                    Text("Приложение использует API «Яндекс.Расписания» \n\nВерсия 1.0 (beta)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(isAppDarkMode ? .white : Color.backgroundBlackStatic)
                        .multilineTextAlignment(.center)
                    
                    
                }
                .padding()
            }
            .navigationDestination(for: String.self) { value in
                if value == "UserAgreementView" {
                    UserAgreementView(path: $path, isAppDarkMode: $isAppDarkMode)
                }
            }
        }
        .animation(.easeIn(duration: 0.4), value: isAppDarkMode)
        
        //        NavigationStack(path: $path) {
        //            ZStack {
        //                Color.background
        //                    .ignoresSafeArea()
        //
        //                VStack {
        //                    Text("Экран настроек")
        //                        .foregroundStyle(Color.accent)
        //
        //                    Button {
        //                        path.append("ServerErrorView")
        //                    } label: {
        //                        Text("Экран Ошибка сервера")
        //                            .foregroundStyle(Color.accent)
        //                    }
        //                    .buttonStyle(.bordered)
        //
        //                    Button {
        //                        path.append("NoInternetView")
        //                    } label: {
        //                        Text("Экран Нет интернета")
        //                            .foregroundStyle(Color.accent)
        //                    }
        //                    .buttonStyle(.bordered)
        //                }
        //            }
        //            .navigationDestination(for: String.self) { value in
        //                if value == "ServerErrorView" {
        //                    ServerErrorView()
        //                } else if value == "NoInternetView" {
        //                    NoInternetView()
        //                }
        //            }
        //        }
    }
}

#Preview {
    @Previewable @State var isAppDarkMode: Bool = false

    SettingsView(isAppDarkMode: $isAppDarkMode)
}
