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
    
    let imageWeather = [
        "cloud.drizzle.fill", 
        "cloud.rain.fill",
        "sun.max.fill",
        "cloud.fill",
        "cloud.sun.fill",
        "cloud.rainbow.half.fill",
        "sun.min.fill"
    ]
    
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
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case generationtimeMs = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone = "timezone"
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation = "elevation"
        case dailyUnits = "daily_units"
        case daily = "daily"
    }
}

struct DailyUnits: Decodable {
    let time: String
    let temperatureTwoMMax: String
    let temperatureTwoMMin: String
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case temperatureTwoMMax = "temperature_2m_max"
        case temperatureTwoMMin = "temperature_2m_min"
    }
}

struct Time: Decodable {
    let time: [String]
    let temperatureTwoMMax: [Double]
    let temperatureTwoMMin: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case temperatureTwoMMax = "temperature_2m_max"
        case temperatureTwoMMin = "temperature_2m_min"
    }
}
