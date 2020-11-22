//
//  DailyWeatherTableViewCell.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 22/11/2020.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayOfTheWeek: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(dailyWeather: DailyWeatherViewModel) {
        self.dayOfTheWeek.text = dailyWeather.dayOfTheWeek
        self.temperature.text = dailyWeather.temperatures
        self.precipitation.text = dailyWeather.precipitation
    }
    
}
