import Foundation

extension CityWeatherViewModel {
    static func mock(city: MockCity) -> CityWeatherViewModel {
        let fileName = "weather.\(city.rawValue.replacingOccurrences(of: "_", with: ".")).json"
        let weather = WeatherResponse.loadFromFile(filename: fileName)
        
        let cityName = city.rawValue.replacingOccurrences(of: "_", with: " ").capitalized
        return CityWeatherViewModel(city: cityName, weather: weather)
    }
}

enum MockCity: String {
    case los_angeles
    case las_vegas
    case new_york
}
