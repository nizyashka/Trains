import Foundation

extension Date {
    func toTimeString(format: String = "HH:mm", locale: Locale = Locale(identifier: "ru_RU")) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.string(from: self)
    }
}
