//
//  WeatherCell.swift
//  Weather
//
//  Created by Evgeniy Maksimov on 21.07.2024.
//

import UIKit

final class WeatherCell: UITableViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var maxTemp: UILabel!
    @IBOutlet var minTemp: UILabel!
    @IBOutlet var imageWeather: UIImageView!
    @IBOutlet var showWarmth: UIProgressView!

    func setUpUI(from data: Weather, and image: [String] ,for indexPath: IndexPath) {
        let imageInfo = image.shuffled()
        imageWeather.image = UIImage(
            systemName: imageInfo[indexPath.row]
        )?.withTintColor(
                .white,
                renderingMode: .alwaysOriginal
            )
        
        dateLabel.text = indexPath.row == 0 ? "Сегодня" : data.daily.time[indexPath.row]
        maxTemp.text = "\(Int(data.daily.temperatureTwoMMax[indexPath.row]))°"
        minTemp.text = "\(Int(data.daily.temperatureTwoMMin[indexPath.row]))°"
        showWarmth.progress = Float(Double.random(in: data.daily.temperatureTwoMMin[indexPath.row]...data.daily.temperatureTwoMMax[indexPath.row])/100 * 2)
        
    }
}
