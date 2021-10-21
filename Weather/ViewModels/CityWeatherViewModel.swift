import Foundation
import SwiftUI

struct CityWeatherViewModel {
    
    let city: String
    private let weather: WeatherResponse
    
    @AppStorage("weather.unit") private var unit: TemperatureUnit = .celsius
    
    init(city: String, weather: WeatherResponse) {
        self.city = city
        self.weather = weather
    }
    
    var icon: String {
        return self.weather.current.weather[0].icon
    }
    
    var temperature: Int {
        return Int(self.weather.current.temp.valueOf(unit: unit))
    }
    
    var description: String {
        return self.weather.current.weather[0].description.capitalized
    }
    
    var max: Int {
        return Int(self.weather.daily[0].temp.max.valueOf(unit: unit))
    }
    
    var min: Int {
        return Int(self.weather.daily[0].temp.min.valueOf(unit: unit))
    }
    
    var hourly: [HourlyViewModel] {
        return self.weather.hourly.map { HourlyViewModel(hourly: $0, unit: self.unit) }
    }
    
    var daily: [DailyViewModel] {
        return self.weather.daily.map { DailyViewModel(daily: $0, unit: self.unit) }
    }
}

struct HourlyViewModel {
    private let hourly: WeatherResponse.Hourly
    private let unit: TemperatureUnit
    
    init(hourly: WeatherResponse.Hourly, unit: TemperatureUnit) {
        self.hourly = hourly
        self.unit = unit
    }
    
    var id: UUID {
        return UUID()
    }
    
    var time: String {
        return Date(timeIntervalSince1970: TimeInterval(self.hourly.dt)).toHourString()
    }
    
    var icon: String {
        return self.hourly.weather[0].icon
    }
    
    var temperature: Int {
        return Int(self.hourly.temp.valueOf(unit: self.unit))
    }
}

struct DailyViewModel {
    private let daily: WeatherResponse.Daily
    private let unit: TemperatureUnit
    
    init(daily: WeatherResponse.Daily, unit: TemperatureUnit) {
        self.daily = daily
        self.unit = unit
    }
    
    var id: UUID {
        return UUID()
    }
    
    var day: String {
        return Date(timeIntervalSince1970: TimeInterval(self.daily.dt)).toDayString()
    }
    
    var icon: String {
        return self.daily.weather[0].icon
    }
    
    var max: Int {
        return Int(self.daily.temp.max.valueOf(unit: self.unit))
    }
    
    var min: Int {
        return Int(self.daily.temp.min.valueOf(unit: self.unit))
    }
}
