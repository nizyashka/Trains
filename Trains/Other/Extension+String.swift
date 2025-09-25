//
//  Extension+String.swift
//  Trains
//
//  Created by Алексей Непряхин on 22.09.2025.
//

import Foundation

extension String {
    func toLocalizedDateString(locale: Locale = Locale(identifier: "ru_RU")) -> String? {
        let parser = DateFormatter()
        parser.dateFormat = "yyyy-MM-dd"
        parser.locale = locale
        
        guard let date = parser.date(from: self) else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = locale
        
        return formatter.string(from: date)
    }
    
    func toDate(format: String = "HH:mm:ss", locale: Locale = Locale(identifier: "ru_RU")) -> Date? {
        let parser = DateFormatter()
        parser.dateFormat = format
        parser.locale = locale
        return parser.date(from: self)
    }
}
