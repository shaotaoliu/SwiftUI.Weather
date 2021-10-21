import Foundation

struct WeatherResponse: Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [WeatherResponse.Daily]
    
    struct Current: Codable {
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
        let wind_speed: Double
        let weather: [Weather]
    }
    
    struct Hourly: Codable {
        let dt: Int
        let temp: Double
        let pop: Double
        let weather: [Weather]
    }

    struct Daily: Codable {
        let dt: Int
        let temp: Temp
        let weather: [Weather]
        let pop: Double
        
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
}
