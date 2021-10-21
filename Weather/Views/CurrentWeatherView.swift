import SwiftUI

struct CurrentWeatherView: View {
    
    let cityWeatherVM: CityWeatherViewModel
    
    var body: some View {
        VStack {
            Text(cityWeatherVM.city)
                .font(.largeTitle)
            
            Text(cityWeatherVM.description)
            
            Text("\(cityWeatherVM.temperature)°")
                .font(.system(size: 100))
            
            HStack {
                Text("H: \(cityWeatherVM.max)°")
                Text("L: \(cityWeatherVM.min)°")
            }
        }
    }
}

struct WeatherHeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        CurrentWeatherView(cityWeatherVM: CityWeatherViewModel.mock(city: .los_angeles))
    }
}
