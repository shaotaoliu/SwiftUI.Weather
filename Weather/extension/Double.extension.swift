import Foundation

extension Double {
    
    func valueOf(unit: TemperatureUnit) -> Double {
        let value = self - 273.5
        return unit == .celsius ? value : (value * 9 / 5 + 32)
    }
    
}
