//
//  NetworkManager.swift
//  Weather
//
//  Created by Evgeniy Maksimov on 21.07.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeather(from url: URL, complishion: @escaping (Result<Weather, AFError>) -> Void){
        AF.request(url)
            .validate()
            .responseJSON { dataResponce in
                switch dataResponce.result {
                case .success(let jsonValue):
                    let weather = Weather.getWeather(from: jsonValue)
                    complishion(.success(weather))
                case .failure(let error):
                    print(error)
                }
            }
    }
}
