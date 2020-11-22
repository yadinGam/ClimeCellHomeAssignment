//
//  CapitalCityDetailsViewController.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 20/11/2020.
//

import UIKit
import MapKit

class CapitalCityDetailsViewController: UIViewController, Alertable , MKMapViewDelegate {

    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var weekDaysWeatherTableView: UITableView!
    
//    var showCelsius = true {
//        didSet {
//            self.weekDaysWeatherTableView.reloadData()
//        }
//    }
    
    var cityViewModel: CityViewModel!
    
    private var weatherViewModel : WeatherViewModel = WeatherViewModel(service: WeatherService()) {
        didSet {
            self.weekDaysWeatherTableView.reloadData()
        }
    }
    
    private func setMapKitView() {
        self.mapKitView.delegate = self
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.cityViewModel.latLng[0], longitude: self.cityViewModel.latLng[1])
        self.mapKitView.addAnnotation(annotation)
        self.mapKitView.centerCoordinate = annotation.coordinate
    }

    @objc func changeMetrics() {
        self.weatherViewModel.isCelsius = !self.weatherViewModel.isCelsius
        self.weekDaysWeatherTableView.reloadData()
    }
    
    private func setRightBarButtonItem() {
        let btn = UIButton(type: .system)
        btn.setTitle("Change matric", for: .normal)//us
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(changeMetrics), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.setRightBarButtonItem()
        self.setMapKitView()
        self.getWeatherForCapitalCity()
    }
    
    private func getWeatherForCapitalCity() {
        self.weatherViewModel.getWeather(lat: cityViewModel.latLng[0], lng: cityViewModel.latLng[0]) {
                [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let weatherViewModel):
                self.weatherViewModel = weatherViewModel
            case .failure(let error):
                self.presentAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func setupTableView() {
        self.weekDaysWeatherTableView.delegate = self
        self.weekDaysWeatherTableView.dataSource = self
        self.weekDaysWeatherTableView.register(UINib(nibName: String(describing:DailyWeatherTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing:DailyWeatherTableViewCell.self))
        self.weekDaysWeatherTableView.estimatedRowHeight = 100
        self.weekDaysWeatherTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.cityViewModel.getName()
    }
    
    deinit {
        print("CapitalCityDetailsViewController - deinitialized")
    }

}

extension CapitalCityDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CapitalCityDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherViewModel.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyWeatherTableViewCell.self) )  as? DailyWeatherTableViewCell else { return UITableViewCell() }
        cell.configure(dailyWeather: self.weatherViewModel.getDailyWeather(by: indexPath.row))
        return cell
    }
}

