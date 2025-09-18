//
//  UserAgreementView.swift
//  Trains
//
//  Created by Алексей Непряхин on 08.09.2025.
//

import SwiftUI

struct UserAgreementView: View {
    @Binding var path: [String]
    let isAppDarkMode = UserDefaults.standard.bool(forKey: "isAppDarkMode")
    
    var body: some View {
        Color(isAppDarkMode ? Color.backgroundBlackStatic : .white)
            .ignoresSafeArea()
            .overlay {
                Text("Пользовательское соглашение")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(isAppDarkMode ? .white : Color.backgroundBlackStatic)
            }
            .navigationTitle("Пользовательское соглашение")
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
    }
}

#Preview {
    @Previewable @State var path: [String] = []
    
    UserAgreementView(path: $path)
}
