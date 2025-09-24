//
//  TrainsApp.swift
//  Trains
//
//  Created by Алексей Непряхин on 29.07.2025.
//

import SwiftUI

@main
struct TrainsApp: App {
    @State private var isAppDarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            TabBarView(isAppDarkMode: $isAppDarkMode)
                .preferredColorScheme(isAppDarkMode ? .dark : .light)
        }
    }
}
