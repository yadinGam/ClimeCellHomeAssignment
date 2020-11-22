//
//  CityViewModel.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 22/11/2020.
//

import Foundation

struct CityViewModel {
    private let city: City
    
    init(_ city: City) {
        self.city = city
    }
    
    func getName() -> String {
        return self.city.name
    }
    
    var latLng : [Double] {
        return self.city.latLng
    }
    
}
