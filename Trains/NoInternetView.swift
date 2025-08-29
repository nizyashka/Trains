//
//  NoInternetView.swift
//  Trains
//
//  Created by Алексей Непряхин on 28.08.2025.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Image("No Internet")
                    .resizable()
                    .frame(width: 223, height: 223)
                    .clipShape(RoundedRectangle(cornerRadius: 70))
                
                Text("Нет интернета")
                    .foregroundStyle(Color.accent)
                    .font(.system(size: 24, weight: .bold))
            }
        }
    }
}

#Preview {
    NoInternetView()
}
