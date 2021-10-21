import SwiftUI

struct DailyWeatherView: View {
    
    let daily: [DailyViewModel]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(daily, id: \.id) { daily in
                    HStack {
                        Text(daily.day)
                            .frame(width: 100, alignment: .leading)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Image(daily.icon)
                        
                        Spacer()
                        
                        Text("\(daily.max)")
                            .padding(.horizontal)
                        
                        Text("\(daily.min)")
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(daily: CityWeatherViewModel.mock(city: .los_angeles).daily)
    }
}
