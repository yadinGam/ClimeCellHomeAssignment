//
//  CountryViewModel.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 21/11/2020.
//

import Foundation

struct CountryViewModel {
    private var country: Country
    
    init(_ country: Country) {
        self.country = country
    }
    
    var description: String {
        return "\(self.country.name), \(self.country.capital)"
    }
    
    var flagImageUrl : URL? {
        guard let url = URL(string: self.country.flag) else {
            return nil
        }
        return url
    }
    
    private var latlng : [Double] {
        return self.country.latlng
    }
    
    func getCapitalCityViewModel() -> CityViewModel {
        return CityViewModel(City(name: self.country.capital, latLng: self.country.latlng))
    }

}
