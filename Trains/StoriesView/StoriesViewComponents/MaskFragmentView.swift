//
//  MaskFragmentView.swift
//  Stories-Demo
//
//  Created by Алексей Непряхин on 02.09.2025.
//

import SwiftUI

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.white)
    }
}

#Preview {
    MaskFragmentView()
}
