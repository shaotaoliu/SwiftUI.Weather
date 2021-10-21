import Foundation

extension Date {
    
    func toTimeString() -> String {
        Formatter.shared.timeFormatter.string(from: self)
    }
    
    func toHourString() -> String {
        Formatter.shared.hourFormatter.string(from: self)
    }
    
    func toDayString() -> String {
        Formatter.shared.dayFormatter.string(from: self)
    }
}

struct Formatter {
    static var shared = Formatter()
    
    private init() {}
    
    lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    lazy var hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter
    }()
    
    lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
}
