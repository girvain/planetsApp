//
//  Network.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 17/05/2023.
//

import Foundation

class Network {
    
    enum NetworkErrorType: Error {
        case networkError
        case timeOut
    }
    
    /**
     Get Requests only
     */
    func get<T: Codable>(url: String, model: T.Type, completion: @escaping (Swift.Result<T, NetworkErrorType>) -> Void) {
        guard let url = URL(string: url) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data{
                do {
                    let res = try decoder.decode(model.self, from: data)
                        completion(.success(res))
                    } catch {
                        completion(.failure(.networkError))
                    }
                }
        }
        task.resume()
    }
}
