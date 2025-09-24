//
//  Extension+Date.swift
//  Trains
//
//  Created by Алексей Непряхин on 22.09.2025.
//

import Foundation

extension Date {
    func toTimeString(format: String = "HH:mm", locale: Locale = Locale(identifier: "ru_RU")) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.string(from: self)
    }
}
