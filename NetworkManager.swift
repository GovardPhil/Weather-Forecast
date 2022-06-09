//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by ПавелК on 15.02.2022.
//

import Foundation

class NetworkManager {
    
    private let apiKey = "215d0c9be300d51b392dfcc7e048161e"
    static let shared = NetworkManager()
    
    private init () {
    }
    
    func getRequest (city : String, completion : @escaping ( _ weather : CurrentWeatherData) -> ()) -> Void {
        let tunnel = "https://"
        let domain = "api.openweathermap.org"
        let method = "/data/2.5/weather"
        let parameters = "?q=\(city)&appid=\(apiKey)"
        let urlString = tunnel + domain + method + parameters
        guard let url = URL(string: urlString) else {
            print("URL invalid")
            return
        }
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            guard let _ = response, let data = data else {
                print("Ответа от сервера нет, данные не получены")
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }

            do {
                _ = try JSONSerialization.jsonObject(with: data, options: [])
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weather = try decoder.decode(CurrentWeatherData.self, from: data)
                
             completion(weather)
            } catch {
                print(error.localizedDescription)
            }
        } .resume()
    }
}

