//
//  Weather.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 22/11/2020.
//

import Foundation

struct DailyWeather: Codable {
    let temp: [Temperature]
    let precipitation: [Precipitation]
    let observationTime: ObservationTime
    let lat, lon: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case precipitation
        case observationTime = "observation_time"
        case lat, lon
    }
}

struct ObservationTime: Codable {
    let value: String
}

struct Precipitation: Codable {
    let observationTime: String
    let max: ValueAndUnits

    enum CodingKeys: String, CodingKey {
        case observationTime = "observation_time"
        case max
    }
}

struct ValueAndUnits: Codable {
    let value: Double
    let units: Units
}

enum Units: String, Codable {
    case c = "C"
    case mmHr = "mm/hr"
    case f = "F"
}

struct Temperature: Codable {
    let observationTime: String
    let min, max: ValueAndUnits?

    enum CodingKeys: String, CodingKey {
        case observationTime = "observation_time"
        case min, max
    }
}
