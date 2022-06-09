//
//  AsyncNetworkManager.swift
//  WeatherForecast
//
//  Created by ПавелК on 15.03.2022.
//

import Foundation

class AsyncNetworkManager {
    
  static let shared = AsyncNetworkManager()
    func getPosts (url : String) async throws -> [ToDo] {
        
        let (data,response) = try await URLSession.shared.data(from: URL(string: url)!)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        guard let object = try? JSONDecoder().decode([ToDo].self, from: data) else {
            throw HttpError.errorDecodingData
        }
        return  object
    }
}
