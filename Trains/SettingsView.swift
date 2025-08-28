//
//  SettingsView.swift
//  Trains
//
//  Created by Алексей Непряхин on 15.08.2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            Text("Экран настроек")
                .foregroundStyle(Color.accent)
        }
    }
}

#Preview {
    SettingsView()
}
