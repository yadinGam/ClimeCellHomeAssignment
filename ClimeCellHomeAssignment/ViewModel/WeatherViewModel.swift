//
//  WeatherViewModel.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 22/11/2020.
//

import Foundation

typealias WeatherViewModelCompletion = (Result<WeatherViewModel,Error>) ->()

class WeatherViewModel {
   
    private let service: WeatherService!
    private var weather: [DailyWeather]
    var isCelsius = true
    
    init(service: WeatherService) {
        self.service = service
        self.weather = [DailyWeather]()
    }
    
    func getDailyWeather(by index: Int) -> DailyWeatherViewModel {
        var model = DailyWeatherViewModel(weather: self.weather[index])
        model.isCelsius = isCelsius
        return model
    }
    
    var numberOfDays: Int {
        get {return self.weather.count}
    }
    
    func getWeather(lat: Double, lng: Double, completion: @escaping WeatherViewModelCompletion) {
        let today = Date()
        let numberOfDaysForToPresent: Int = 5
        
        //format the endDate
        //2020-11-27T15:30:50Z
        
        
        guard let endDate = Calendar.current.date(byAdding: .day, value: numberOfDaysForToPresent, to: today) else {
            return
        }
        
        self.service.getDailyWeather(lat: lat , lng: lng,endDate: endDate) { response in
            switch response {
            case .success(let weather):
                self.weather = weather
                completion(.success(self))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
