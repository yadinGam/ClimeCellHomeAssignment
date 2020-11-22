//
//  DailyWeatherViewModel.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 23/11/2020.
//

import Foundation

struct DailyWeatherViewModel {
    let weather: DailyWeather
    
    var isCelsius = true
    
    init(weather: DailyWeather) {
        self.weather = weather
    }
    
    var dayOfTheWeek : String {
        get { return Date.getDayOfTheWeek(self.weather.observationTime.value) ?? ""}
    }
    
    var temperatures : String {
       
        get {
            var str = ""
            if (self.isCelsius) {
                if let x = self.weather.temp[0].min {
                    str = str + String(format: "%.2f", x.value)
                    if let y = self.weather.temp[1].max {
                        str = str + String(format: "- %.2f", y.value)
                    }
                } else {
                    if let y = self.weather.temp[1].max {
                        str = str + String(format: "%.2f", y.value)
                    }
                }
                str = str + "\(Units.c)"
            } else {
                if let x = self.weather.temp[0].min {
                    str = str + String (format: "%.2f", x.value * (9/5) + 32 )
                    if let y = self.weather.temp[1].max {
                        str = str + String(format: "- %.2f", y.value * (9/5) + 32)
                    }
                } else {
                    if let y = self.weather.temp[1].max {
                        str = str + String(format: "%.2f", y.value * (9/5) + 32)
                    }
                }
                str = str + "\(Units.f)"
            }
            return str
        }
    }
    
    var precipitation : String {
        get { return "\(weather.precipitation[0].max.value) \(weather.precipitation[0].max.units)" }
    }
}
