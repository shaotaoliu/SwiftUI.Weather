import SwiftUI

struct CityWeatherView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    var cityWeatherVM: CityWeatherViewModel
    
    var body: some View {
        VStack {
            CurrentWeatherView(cityWeatherVM: cityWeatherVM)
                .padding()
            
            Divider().background(.white)
            
            HourlyWeatherView(hourly: cityWeatherVM.hourly)
                .padding()
            
            Divider().background(.white)
            
            DailyWeatherView(daily: cityWeatherVM.daily)
                .padding()
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton)
        
        /*
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                BackToListIcon
            }
        }
         */
    }
    
    var BackButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrowshape.turn.up.backward")
                .foregroundColor(.white)
        })
    }
    
    var BackToListIcon: some View {
        VStack {
            Divider()
                .background(.white)
            
            HStack {
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "list.dash")
                        .padding(.trailing, 5)
                        .padding(.top, 5)
                        .foregroundColor(.white)
                })
            }
        }
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(cityWeatherVM: CityWeatherViewModel.mock(city: .los_angeles))
    }
}
