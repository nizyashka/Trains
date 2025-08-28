//
//  SettingsView.swift
//  Trains
//
//  Created by Алексей Непряхин on 15.08.2025.
//

import SwiftUI

struct SettingsView: View {
    @State var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                    Text("Экран настроек")
                        .foregroundStyle(Color.accent)
                    
                    Button {
                        path.append("ServerErrorView")
                    } label: {
                        Text("Экран Ошибка сервера")
                            .foregroundStyle(Color.accent)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        path.append("NoInternetView")
                    } label: {
                        Text("Экран Нет интернета")
                            .foregroundStyle(Color.accent)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "ServerErrorView" {
                    ServerErrorView()
                } else if value == "NoInternetView" {
                    NoInternetView()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
