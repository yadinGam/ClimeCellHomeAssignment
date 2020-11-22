//
//  WeatherService.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 22/11/2020.
//

import Foundation
import Alamofire

typealias WeatherCompletion = (Result<[DailyWeather],Error>) ->()

protocol WeatherApi {
    func getDailyWeather(lat: Double ,lng: Double, completion: @escaping WeatherCompletion)
}

class WeatherService : WeatherApi {
    
    private let apiKey = "mFW54hIC4r5puNkKBrcfQ3Xy3dqFYXCJ"
    private let baseWeatherUrl: String = "https://api.climacell.co/v3/weather/forecast/daily"
    
    func getDailyWeather(lat: Double ,lng: Double, completion: @escaping WeatherCompletion) {
        let url = "\(self.baseWeatherUrl)?lat=\(lat)&lon=\(lng)&unit_system=si&start_time=now&fields=precipitation%2Ctemp&apikey=\(apiKey)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            data in
            if let error = data.error {
                completion(.failure(error))
            }
            guard let data = data.data else {
                return
            }
            do {
                let weather = try JSONDecoder().decode([DailyWeather].self, from: data)
                completion(.success(weather))
            } catch let error{
                completion(.failure(error))
            }
        }
    }
}
