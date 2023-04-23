import SwiftUI

extension Color {
    
    static let greenBackground = Color("Green")
}

extension View {
    func formatDate(time: Date)-> String {
        let components = Calendar.current.dateComponents([.hour, .minute, .day, .year, .month], from: time)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let month = components.month ?? 0
        let year = components.year ?? 0
        let day = components.day ?? 0
        return "\(day).\(month).\(year),\(hour):\(minute)"
    }
}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

