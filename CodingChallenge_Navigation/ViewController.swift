//
//  ViewController.swift
//  CodingChallenge_Navigation
//
//  Created by Rolan Marat on 1/22/23.
//

import UIKit

class ViewController: UIViewController {
    private var cities = ["Florianópolis", "Buenos Aires", "Miami", "New York", "San Francisco", "Berlin", "Nice", "Rome", "Istanbul", "Bangalore"]
    
    private var cityCountryDictionary: [String:String] = ["Florianópolis": "Brazil", "Buenos Aires": "Argentina", "Miami": "USA", "New York": "USA", "San Francisco": "USA", "Berlin": "Germany", "Nice": "France", "Rome": "Italy", "Istanbul": "Turkey", "Bangalore": "India"]
    
    struct Constants {
        static let cellIdentifier = "CityCell"
    }
    
    @IBOutlet var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        citiesTableView.register(UITableViewCell.self,
                                 forCellReuseIdentifier: Constants.cellIdentifier)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier,
                                                       for: indexPath)
        var cellContentConfiguration = cell.defaultContentConfiguration()
        let countryName = cities[indexPath.row]
        cellContentConfiguration.text = countryName
        cellContentConfiguration.secondaryText = cityCountryDictionary[countryName]
        cell.contentConfiguration = cellContentConfiguration
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        if tableView.isLastRow(indexPath) {
            performSegue(withIdentifier: "showCityDetails", sender: self)
            return
        }
        
        let modalController = UIViewController()
        
        if indexPath.isEven() {
            modalController.view.backgroundColor = .blue
            present(modalController, animated: true)
            return
        }
        
        modalController.view.backgroundColor = .green
        navigationController?.pushViewController(modalController, animated: true)
    }
}

extension IndexPath {
    func isEven() -> Bool {
        return row % 2 == 0
    }
}

extension UITableView {
    func isLastRow(_ indexPath: IndexPath) -> Bool {
        let numberOfRows = numberOfRows(inSection: numberOfSections - 1) - 1
        return indexPath.row == numberOfRows
    }
}
