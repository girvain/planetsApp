//
//  Network.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 17/05/2023.
//

import Foundation

class Network {
    
//    func fetchFilms(completionHandler: @escaping ([Film]) -> Void) {
//        let url = URL(string: domainUrlString + "films/")!
//
//        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//          if let error = error {
//            print("Error with fetching films: \(error)")
//            return
//          }
//
//          guard let httpResponse = response as? HTTPURLResponse,
//                (200...299).contains(httpResponse.statusCode) else {
//            print("Error with the response, unexpected status code: \(response)")
//            return
//          }
//
//          if let data = data,
//            let filmSummary = try? JSONDecoder().decode(FilmSummary.self, from: data) {
//            completionHandler(filmSummary.results ?? [])
//          }
//        })
//        task.resume()
//      }
    
    /**
     Get Requests only
     */
    func callAPI<T: Codable>(url: String, model: T.Type, completion: @escaping (Swift.Result<T, Error>) -> Void) {
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
                        completion(.failure("Failed to decode json" as! Error))
                    }
                }
        }
        task.resume()
    }
}
