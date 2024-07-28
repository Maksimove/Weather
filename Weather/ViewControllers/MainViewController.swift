//
//  ViewController.swift
//  Weather
//
//  Created by Evgeniy Maksimov on 10.07.2024.
//

import UIKit

final class MainViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var currentTemperature: UILabel!
    @IBOutlet var descriptionTemperature: UILabel!
    @IBOutlet var rangeTemperature: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var weatherDetalis: UIStackView!
    //MARK: - Private properties
    private let networkManager = NetworkManager.shared
    private var weather: Weather?
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = setBackgroundColor()
        tableView.rowHeight = 60
        tableView.layer.cornerRadius = 13
        tableView.backgroundColor = setBackgroundColor()
        fetchWeather()
    }
    //MARK: - Private methods
    private func fetchWeather() {
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&daily=temperature_2m_max,temperature_2m_min")!
        
        networkManager.fetchWeather(from: url) { [weak self] result in
            switch result {
            case .success(let weather):
                let weatherInfo = weather
                self?.weather = weatherInfo
                self?.setUpUI(from: weatherInfo)
                self?.weatherDetalis.isHidden.toggle()
                self?.tableView.reloadData()
                self?.tableView.isHidden.toggle()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpUI(from data: Weather) {
        currentTemperature.text = "\(Int(Double.random(in: (data.daily.temperatureTwoMMin.first ?? 0)...(data.daily.temperatureTwoMMax.first ?? 0))))°"
        descriptionTemperature.text = data.description.randomElement()
        rangeTemperature.text = "Макс.: \(Int(data.daily.temperatureTwoMMax.first ?? 0))°, мин.: \(Int(data.daily.temperatureTwoMMin.first ?? 0))"
    }
    private func setBackgroundColor() -> UIColor {
        UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1)
    }
}
    //MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weather?.daily.time.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        guard let cell = cell as? WeatherCell else { return UITableViewCell() }
        if let weather {
            cell.setUpUI(from: weather, and: weather.imageWeather, for: indexPath)
            cell.backgroundColor = setBackgroundColor()
        }
        return cell
    }
}
    //MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let contentView = UIView()
        contentView.backgroundColor = setBackgroundColor()
        let header = UILabel(
            frame: CGRect(
                x: 20,
                y: 0,
                width: tableView.frame.width - 40,
                height: 20
            )
        )
        header.text = "Погода на неделю"
        header.textColor = .white
        contentView.addSubview(header)
        
        return contentView
    }
}
