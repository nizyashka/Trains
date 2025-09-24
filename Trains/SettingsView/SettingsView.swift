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
                Color(Color.background)
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 38) {
                    Toggle(isOn: $isAppDarkMode) {
                        Text("Темная тема")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(Color.accent)
                    }
                    .tint(.blue)
                    
                    Button {
                        path.append("UserAgreementView")
                    } label: {
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(Color.accent)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.accent)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    
                    Spacer()
                    
                    Text("Приложение использует API «Яндекс.Расписания» \n\nВерсия 1.0 (beta)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.accent)
                        .multilineTextAlignment(.center)
                    
                    
                }
                .padding()
            }
            .navigationDestination(for: String.self) { value in
                if value == "UserAgreementView" {
                    let userAgreementViewModel = UserAgreementViewModel()
                    
                    UserAgreementView(viewModel: userAgreementViewModel, path: $path)
                }
            }
        }
    }
}

//#Preview {
//    SettingsView()
//}
