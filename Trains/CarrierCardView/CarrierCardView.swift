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
        VStack(alignment: .leading, spacing: 16) {
            Image("rzdBigLogo")
                .resizable()
                .frame(width: 343, height: 104)
            
            Text("ОАО «РЖД»")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.accent)
            
            VStack(alignment: .leading) {
                Text("E-mail")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color.accent)
                
                Text("i.lozgkina@yandex.ру")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading) {
                Text("Телефон")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color.accent)
                
                Text("+7 (904) 329-27-71")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.blue)
            }
            
            Spacer()
        }
        .navigationTitle("Информация о перевозчике")
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
