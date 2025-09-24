//
//  UserAgreementView.swift
//  Trains
//
//  Created by Алексей Непряхин on 08.09.2025.
//

import SwiftUI

struct UserAgreementView: View {
    @State var viewModel: UserAgreementViewModel
    @Binding var path: [String]
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("Загружаем пользовательское соглашение...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundStyle(Color.accent)
                    .font(.system(size: 16, weight: .medium))
            } else {
                Color(Color.background)
                    .ignoresSafeArea()
                    .overlay {
                        Text(viewModel.copyrightText)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(Color.accent)
                            .lineLimit(nil)
                            .padding()
                    }
            }
        }
        .task {
            await viewModel.loadCopyright()
            isLoading = false
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

//#Preview {
//    @Previewable @State var path: [String] = []
//
//    UserAgreementView(path: $path)
//}
