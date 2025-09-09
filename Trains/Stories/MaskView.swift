//
//  MaskView.swift
//  Stories-Demo
//
//  Created by Алексей Непряхин on 02.09.2025.
//

import SwiftUI

struct MaskView: View {
    let numberOfSections: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

#Preview {
    Color.story1Background
        .ignoresSafeArea()
        .overlay(
            MaskView(numberOfSections: 5)
                .padding()
        )
}
