//
//  MainViewController.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 20/11/2020.
//

import UIKit

class MainViewController: UIViewController, Alertable {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countriesTableView: UITableView!
    
    private var countriesViewModel = CountriesViewModel(service: CountriesService()) {
        didSet {
            self.countriesTableView.reloadData()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countriesTableView.delegate = self
        self.countriesTableView.dataSource = self
        self.searchBar.delegate = self
        self.setTableView()
        self.countriesViewModel.getCountries {
            [weak self] result in
            guard let self = self else {
            return
            }
            switch result {
            case .success(let countriesViewModel):
                self.countriesViewModel = countriesViewModel
            case .failure(let error):
                self.presentAlert(message: error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Countries List"
    }
    
    private func setTableView() {
        self.countriesTableView.register(UINib(nibName: String(describing:CountryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing:CountryTableViewCell.self))
        self.countriesTableView.estimatedRowHeight = 100
        self.countriesTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func showSelectedCityDetails(_ cityViewModel: CityViewModel) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "CapitalCityDetailsViewController") as! CapitalCityDetailsViewController
        vc.cityViewModel = cityViewModel
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }
    
    deinit {
        print("MainViewController been deinitialized from memory")
    }
    
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? CountryTableViewCell else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        self.showSelectedCityDetails(self.countriesViewModel.getCapital(for: indexPath.row))
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countriesViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self) )  as? CountryTableViewCell else { return UITableViewCell() }
        cell.configure(viewModel: self.countriesViewModel.getItemViewModel(for: indexPath.row))
        return cell
    }
}

extension MainViewController :  UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchTerm = searchText.trimWhitespaces()
        self.countriesViewModel.set(searchTerm: searchTerm)
        self.countriesTableView.reloadData()
    }
}


