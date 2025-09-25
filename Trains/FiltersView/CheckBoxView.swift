//
//  CheckBoxView.swift
//  Trains
//
//  Created by Алексей Непряхин on 28.08.2025.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    
    let timeFilterText: String
    
    var body: some View {
        HStack {
            Text(timeFilterText)
                .foregroundStyle(Color.accent)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            
            Button(action: {
                isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundStyle(Color.accent)
                    .font(.system(size: 17, weight: .regular))
            }
        }
    }
}

#Preview {
    @Previewable @State var isChecked: Bool = false
    @Previewable var timeFilterText: String = "Утро 06:00 - 12:00"
    
    CheckBoxView(isChecked: $isChecked, timeFilterText: timeFilterText)
}
