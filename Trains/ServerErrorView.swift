//
//  ServerErrorView.swift
//  Trains
//
//  Created by Алексей Непряхин on 28.08.2025.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("Server Error")
                .resizable()
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            
            Text("Ошибка сервера")
                .foregroundStyle(Color.accent)
                .font(.system(size: 24, weight: .bold))
        }
    }
}

#Preview {
    ServerErrorView()
}
