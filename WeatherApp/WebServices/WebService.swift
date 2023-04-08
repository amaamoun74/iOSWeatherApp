//
//  webService.swift
//  WeatherApp
//
//  Created by ahmed on 05/04/2023.
//

import Foundation

final class NetworkManager<T: Codable>
{
    static func fetch (for url: URL , completion: @escaping (Result<T, NetworkError>) -> Void)
    {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error != nil else {
                print("API ERROR \(String(describing: error!))")
                completion(.failure(.error(error: error!.localizedDescription)))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 210 else
            {
                print("RESPONSE ERROR")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("DATA ERROR")
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            }
            catch let err {
                print("DECODING ERROR \(String(describing: err))")
                completion(.failure(.decodingError(error: err.localizedDescription)))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error (error: String)
    case decodingError(error: String)
}
