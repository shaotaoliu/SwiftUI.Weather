import SwiftUI

struct ContentView: View {
    
    @AppStorage("weather.unit") private var unit: TemperatureUnit = .celsius
    @EnvironmentObject var store: Store
    @State var showAddCitySheet = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(store.cityWeatherListVM, id: \.city) { cityWeather in
                        NavigationLink(destination: CityWeatherView(cityWeatherVM: cityWeather)) {
                            HStack {
                                Text(cityWeather.city)
                                    .font(.title2)
                                    .frame(width: 150, alignment: .leading)
                                
                                Spacer()
                                
                                Image(cityWeather.icon)
                                
                                Spacer()
                                
                                Text("\(cityWeather.temperature)°")
                                    .font(.system(size: 40))
                                    .frame(width: 80, alignment: .trailing)
                            }
                        }
                        .padding(.vertical, 15)
                    }
                    .onDelete(perform: { offsets in
                        store.removeCityWeather(offsets: offsets)
                    })
                    .listRowBackground(Color.blue)
                    .listRowSeparatorTint(.white)
                }
                .padding(.top, 10)
                .foregroundColor(.white)
                .background(Color.black)
                .ignoresSafeArea()
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: CFButton, trailing: AddButton)
            }
            .onAppear() {
                if store.cityWeatherListVM.isEmpty, !store.isLoading {
                    showAddCitySheet = true
                }
            }
            
            if store.isLoading {
                ProgressView("Fetching data...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.white)
            }
        }
    }
    
    var CFButton: some View {
        Button(action: {
            unit = unit == .celsius ? .fahrenheit : .celsius
        }, label: {
            Text("°C")
                .fontWeight(unit == .celsius ? .bold : .regular)
                .foregroundColor(unit == .celsius ? .white : .gray) +
            
            Text(" / ")
                .foregroundColor(.white) +
            
            Text("°F")
                .fontWeight(unit == .fahrenheit ? .bold : .regular)
                .foregroundColor(unit == .fahrenheit ? .white : .gray)
        })
    }
    
    var AddButton: some View {
        Button(action: {
            showAddCitySheet = true
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
        })
        .fullScreenCover(isPresented: $showAddCitySheet) {
            AddCityView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let store: Store = {
        let store = Store()
        store.addCityWeather(cityWeather: CityWeatherViewModel.mock(city: .los_angeles))
        store.addCityWeather(cityWeather: CityWeatherViewModel.mock(city: .las_vegas))
        store.addCityWeather(cityWeather: CityWeatherViewModel.mock(city: .new_york))
        return store
    }()
    
    static var previews: some View {
        ContentView().environmentObject(store)
    }
}
