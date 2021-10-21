import Foundation
import CoreLocation
import SwiftUI

class Store: ObservableObject {
        
    @Published var cityWeatherListVM: [CityWeatherViewModel] = []
    @AppStorage("weather.cities") var citiesInAppStorage: String = ""
    
    func addCityWeather(cityWeather: CityWeatherViewModel) {
        cityWeatherListVM.append(cityWeather)
        syncAppStorage()
    }
    
    func removeCityWeather(offsets: IndexSet) {
        cityWeatherListVM.remove(atOffsets: offsets)
        syncAppStorage()
    }
    
    private func syncAppStorage() {
        citiesInAppStorage = cityWeatherListVM
            .map { $0.city }
            .joined(separator: ",")
    }
    
    
    @Published var isLoading = false
    @Published var hasError = false
    @Published var appErrors: [AppError] = []
    
    func addError(errorMessage: String) {
        hasError = true
        appErrors.append(AppError(errorMessage: errorMessage))
    }
    
    func addError(error: AppError) {
        hasError = true
        appErrors.append(error)
    }
    
    func clearErrors() {
        hasError = false
        appErrors.removeAll()
    }
    
    init(loadFromAppStorage: Bool = false) {
        if loadFromAppStorage, citiesInAppStorage != "" {
            let cities = citiesInAppStorage.components(separatedBy: ",")
            self.loadFromAppStorage(cities: cities)
        }
    }
    
    func loadFromAppStorage(cities: [String]) {
        
        let group = DispatchGroup()
        isLoading = true
        clearErrors()
        
        for city in cities {
            group.enter()
            
            fetchWeather(city: city) { result in
                switch result {
                    
                case .success(let weather):
                    self.addCityWeather(cityWeather: weather)
                    
                case .failure(let error):
                    self.addError(error: error)
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
    
    func fetchWeather(city: String, onSuccess: @escaping () -> Void) {

        //UIApplication.shared.endEditing()
        
        isLoading = true
        clearErrors()
        
        fetchWeather(city: city) { result in
            switch result {
                
            case .success(let weather):
                self.addCityWeather(cityWeather: weather)
                self.isLoading = false
                onSuccess()
                
            case .failure(let error):
                self.addError(error: error)
                self.isLoading = false
            }
        }
    }
    
    func fetchWeather(city: String, completion: @escaping (Result<CityWeatherViewModel, AppError>) -> Void) {
        
        CLGeocoder().geocodeAddressString(city) { placemarks, error in
            
            if let error = error as? CLError {
                
                switch error.code {
                    
                case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                    completion(.failure(AppError(errorMessage: "Unable to find the city: \(city)")))
                    
                case .network:
                    completion(.failure(AppError(errorMessage: "Network is unavailable")))
                    
                default:
                    completion(.failure(AppError(errorMessage: error.localizedDescription)))
                }
                
                return
            }
            
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                
                let url = URL.getOpenWeatherURL(lat: lat, lon: lon)
                
                WebService.shared.fetch(urlString: url) { (result: Result<WeatherResponse, WebError>) in
                    switch result {
                    case .success(let weather):
                        DispatchQueue.main.async {
                            completion(.success(CityWeatherViewModel(city: city, weather: weather)))
                        }
                        
                    case .failure(let error):
                        switch error {
                        case .invalidURL(urlString: let urlString):
                            completion(.failure(AppError(errorMessage: "Invalid URL string: \(urlString)")))
                            
                        case .serverError(error: let error):
                            completion(.failure(AppError(errorMessage: "Server error: \(error)")))
                            
                        case .emptyData:
                            completion(.failure(AppError(errorMessage: "Data is empty")))
                            
                        case .decodingError(error: let error):
                            completion(.failure(AppError(errorMessage: "Failed to decode data: \(error)")))
                        }
                    }
                }
            }
        }
    }
}
