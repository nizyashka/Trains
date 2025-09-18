//
//  TrainsApp.swift
//  Trains
//
//  Created by Алексей Непряхин on 29.07.2025.
//

import SwiftUI

@main
struct TrainsApp: App {
    let isAppDarkMode = UserDefaults.standard.bool(forKey: "isAppDarkMode")
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .preferredColorScheme(isAppDarkMode ? .dark : .light)
        }
    }
}
