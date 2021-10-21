import Foundation

extension URL {
    private static let key = "d999f11b76ffe4ffaeddc631fa2ec759"
    
    static func getOpenWeatherURL(lat: Double, lon: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=\(key)"
    }
}
