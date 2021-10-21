import SwiftUI

struct AddCityView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var store: Store
    @State private var city: String = ""
    @FocusState private var focusedOn: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    VStack {
                        HStack {
                            TextField("Enter City", text: $city, onCommit: {
                                addWeather()
                            })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, 5)
                                .focused($focusedOn)
                                .onAppear() {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        focusedOn = true
                                    }
                                }
                            
                            Button(action: {
                                self.city = ""
                                focusedOn = true
                            }, label: {
                                Image(systemName: "xmark.circle")
                                    .font(.title3)
                                    .disabled(city == "")
                            })
                        }
                        
                        HStack {
                            Button("Add") {
                                addWeather()
                            }
                            .buttonStyle(BlueButtonStyle(width: 100))
                            .alert("Error", isPresented: $store.hasError, presenting: store.appErrors) { errors in
                                Button("OK") {
                                    store.clearErrors()
                                    focusedOn = true
                                }
                            } message: { errors in
                                Text(errors
                                        .map { $0.errorMessage }
                                        .joined(separator: "\n"))
                            }
                            
                            Spacer()
                                .frame(width: 50)
                            
                            Button("Cancel") {
                                presentationMode.wrappedValue.dismiss()
                            }
                            .buttonStyle(BlueButtonStyle(width: 100))
                        }
                        .padding(.top)
                    }
                    .padding()
                    .frame(maxHeight: 200)
                    .background(Color(red: 0.85, green: 0.93, blue: 0.99))
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 50)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .navigationBarHidden(true)
            }
            
            if store.isLoading {
                ProgressView("Fetching data...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.white)
            }
        }
    }
    
    func addWeather() {
        if city == "" {
            store.addError(errorMessage: "Please enter city")
        }
        else if store.cityWeatherListVM.contains(where: {$0.city == city}) {
            store.addError(errorMessage: "City has already been added")
        }
        else {
            store.fetchWeather(city: city) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct BlueButtonStyle: ButtonStyle {
    let width: Double
    
    init(width: Double) {
        self.width = width
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.frame(width: width)
            .padding(.vertical, 8)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView().environmentObject(Store())
    }
}
