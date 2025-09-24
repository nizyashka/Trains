//
//  MainViewModel.swift
//  Trains
//
//  Created by Алексей Непряхин on 15.09.2025.
//

import SwiftUI

@MainActor
@Observable
class MainViewModel {
    var isAppDarkMode = UserDefaults.standard.bool(forKey: "isAppDarkMode")
    var fromCity: Settlement?
    var fromStation: Station?
    var toCity: Settlement?
    var toStation: Station?
    var listOfCarriersViewIsPresenting = false
    var stories: [Story] = [.story1, .story2, .story3]
    
    var isFormValid: Bool {
        fromCity != nil &&
        fromStation != nil &&
        toCity != nil &&
        toStation != nil
    }
}
