//
//  MapViewController.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 21/11/2020.
//

import UIKit

class MapViewController: UIViewController {

    var cities: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cities = self.cities else {
            print("cities array is nil")
            return
        }
        for city in cities {
            print(city)
        }
    }
}
