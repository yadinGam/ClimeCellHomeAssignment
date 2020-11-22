//
//  CountriesService.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 21/11/2020.
//

import Foundation
import Alamofire

typealias CountriesCompletion = (Result<[Country],Error>) ->()

protocol CountriesApi {
    func getCountries(completion: @escaping CountriesCompletion)
}

class CountriesService : CountriesApi {
   
    private let baseUrl: String = "https://restcountries.eu/rest/v2/all"
    
    func getCountries(completion: @escaping CountriesCompletion) {
        AF.request(self.baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            data in
            if let error = data.error {
                completion(.failure(error))
            }
            guard let data = data.data else {
                //no data error - TODO
                return
            }
            do {
                let response = try JSONDecoder().decode([Country].self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
