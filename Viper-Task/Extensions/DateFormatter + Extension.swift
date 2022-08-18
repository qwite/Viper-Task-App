import Foundation

// MARK: - DateFormatter Extension
extension DateFormatter {
    static let fullDate: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        return df
    }()
    
    static let fullDateTime: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return df
    }()
    
    static let iso8601: ISO8601DateFormatter = {
        let df = ISO8601DateFormatter()
        
        return df
    }()
    
    static func getFullDate(date: String) -> String? {
        guard let parsedDate = iso8601.date(from: date) else { return nil }
        
        return DateFormatter.fullDate.string(from: parsedDate)
    }
    
    static func getFullDateTime(date: String) -> String? {
        guard let parsedDate = iso8601.date(from: date) else { return nil }
        
        return DateFormatter.fullDateTime.string(from: parsedDate)
    }
}
