import SwiftUI

struct HourlyWeatherView: View {
    
    let hourly: [HourlyViewModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(hourly, id: \.id) { hourly in
                    VStack(spacing: 10) {
                        Text("\(hourly.time)")
                        Image(hourly.icon)
                        Text("\(hourly.temperature)°")
                    }
                }
            }
        }
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherView(hourly: CityWeatherViewModel.mock(city: .los_angeles).hourly)
    }
}
