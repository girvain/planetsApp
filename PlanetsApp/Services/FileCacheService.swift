//
//  FileCacheService.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 21/05/2023.
//

import Foundation

class FileCacheService {
    
    func loadJSON<T: Codable>(model: T.Type, withFilename filename: String) throws -> T? {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            let fileURL = url.appendingPathComponent(filename)
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            let jsonData = try jsonDecoder.decode(T.self, from: data)
            return jsonData
        }
        return nil
    }
    
    func save<T: Codable>(model: T, toFilename filename: String) throws {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(model.self)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent(filename)
        if let stringData = json?.data(using: .utf8) {
            try stringData.write(to: path)
        }
    }
    
}
