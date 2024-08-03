//
//  Weather.swift
//  Weather
//
//  Created by Evgeniy Maksimov on 10.07.2024.
//

import Foundation

struct Weather: Decodable {
    let latitude: Double
    let longitude: Double
    let generationtimeMs: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Double
    let dailyUnits: DailyUnits
    let daily: Time
    
    var imageWeather: [String] {
        [
            "cloud.drizzle.fill",
            "cloud.rain.fill",
            "sun.max.fill",
            "cloud.fill",
            "cloud.sun.fill",
            "cloud.rainbow.half.fill",
            "sun.min.fill"
        ]
    }
    
    var description: [String] {
        [
            "Преимущественно солнечно", 
            "Ожидается дождь во второй половине дня",
            "Переменная облачность",
            "Ливень",
            "Солнечно",
            "Ясно",
            "Возможен дождь"
        ]
    }
    
    init(weatherData:[String: Any]) {
        latitude = weatherData["latitude"] as? Double ?? 0
        longitude = weatherData["longitude"] as? Double ?? 0
        generationtimeMs = weatherData["generationtime_ms"] as? Double ?? 0
        utcOffsetSeconds = weatherData["utc_offset_seconds"] as? Int ?? 0
        timezone = weatherData["timezone"] as? String ?? ""
        timezoneAbbreviation = weatherData["timezone_abbreviation"] as? String ?? ""
        elevation = weatherData["elevation"] as? Double ?? 0
        dailyUnits = DailyUnits(weatherData: weatherData["daily_units"] as? [String : Any] ?? [:])
        daily = Time(weatherData: weatherData["daily"] as? [String: Any] ?? [:])
    }
    
    static func getWeather(from jsonValue: Any) -> Weather {
        guard let weatherData = jsonValue as? [String: Any] else { return Weather(weatherData: [:]) }
        let weather = Weather(weatherData: weatherData)
        return weather
    }
}

struct DailyUnits: Decodable {
    let time: String
    let temperatureTwoMMax: String
    let temperatureTwoMMin: String
    
    init(weatherData: [String: Any]) {
        time = weatherData["time"] as? String ?? ""
        temperatureTwoMMax = weatherData["temperature_2m_max"] as? String ?? ""
        temperatureTwoMMin = weatherData["temperature_2m_min"] as? String ?? ""
    }
}

struct Time: Decodable {
    let time: [String]
    let temperatureTwoMMax: [Double]
    let temperatureTwoMMin: [Double]
    
    init(weatherData: [String: Any]) {
        time = weatherData["time"] as? [String] ?? []
        temperatureTwoMMax = weatherData["temperature_2m_max"] as? [Double] ?? []
        temperatureTwoMMin = weatherData["temperature_2m_min"] as? [Double] ?? []
    }
}
