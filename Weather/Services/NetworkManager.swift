//
//  NetworkManager.swift
//  Weather
//
//  Created by Evgeniy Maksimov on 21.07.2024.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
}


final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeather(from url: URL, complishion: @escaping (Result<Weather, NetworkError>) -> Void){
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                complishion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    complishion(.success(weather))
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
