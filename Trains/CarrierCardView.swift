//
//  CarrierCardView.swift
//  Trains
//
//  Created by Алексей Непряхин on 28.08.2025.
//

import SwiftUI

struct CarrierCardView: View {
    @Binding var path: [Route]
    
    var body: some View {
        Text("Карточка перевозчика")
            .foregroundStyle(Color.accent)
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
    
    CarrierCardView(path: $path)
}
