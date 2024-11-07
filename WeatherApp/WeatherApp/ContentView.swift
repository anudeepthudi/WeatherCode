//
//  ContentView.swift
//  WeatherApp
//
//  Created by anudeep thudi on 10/07/24.
//
 
import Foundation
import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Weather App")
                .font(.largeTitle)
                .bold()
                .padding()
            
            HStack {
                TextField("Enter city", text: $viewModel.cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(action: {
                    viewModel.fetchWeather()
                }) {
                    Text("Search")
                        .bold()
                }
                .padding(.trailing)
            }
            .padding()
            
            VStack(spacing: 20) {
                if !viewModel.icon.isEmpty {
                    Image(uiImage: loadImage(icon: viewModel.icon))
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                
                Text("Temperature")
                    .font(.headline)
                Text(viewModel.temperature)
                    .font(.title)
                
                Text("Weather Description")
                    .font(.headline)
                Text(viewModel.description.capitalized)
                    .font(.title2)
                
                Text("Humidity")
                    .font(.headline)
                Text(viewModel.humidity)
                    .font(.title2)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            viewModel.loadLastCity()
        }
    }
    
    func loadImage(icon: String) -> UIImage {
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png"),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return UIImage(systemName: "cloud")!
        }
        return image
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
