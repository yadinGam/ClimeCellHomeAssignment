//
//  CountriesViewModel.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 22/11/2020.
//

import Foundation

class CountriesViewModel {
    private var model: [Country]
    private var searchTerm: String?
    private let service: CountriesService!
    
    private var filteredModel : [Country] {
        guard let searchTerm = self.searchTerm, !searchTerm.isEmpty else {
            return model
        }
        return self.model.filter { $0.name.lowercased().contains(searchTerm.lowercased()) || $0.capital.lowercased().contains(searchTerm.lowercased()) }
    }
    
    init(service: CountriesService) {
        self.service = service
        self.model = [Country]()
    }
    
    var numberOfItems : Int {
        get { return self.filteredModel.count }
    }
    
    func getItemViewModel(for index : Int) -> CountryViewModel {
        return CountryViewModel(self.filteredModel[index])
    }
    
    func getCapital(for index : Int) -> CityViewModel {
        return CountryViewModel(self.filteredModel[index]).getCapitalCityViewModel()
    }
    
    func latlng(for index : Int) -> [Double] {
        return self.filteredModel[index].latlng
    }
    
    func set(searchTerm: String?) {
        self.searchTerm = searchTerm
    }
    
    typealias CountriesViewModelCompletion = (Result<CountriesViewModel,Error>) ->()
    
    func getCountries(completion: @escaping CountriesViewModelCompletion) {
        self.service.getCountries {
            [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                        self.model = countries
                    completion(.success(self))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}
