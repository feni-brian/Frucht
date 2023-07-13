//
//  BundleExtension.swift
//  Frucht
//
//  Created by Feni Brian on 19/07/2022.
//

import Foundation

// 
extension Bundle {
    func decode<T: Codable>(from file: String) -> T {
        let decoder = JSONDecoder()
        guard let url = self.url(forResource: file, withExtension: "json") else { fatalError("Failed to locate \(file) in bundle!") }
        guard let data = try? Data(contentsOf: url) else { fatalError("Failed to load \(file) from bundle!") }
        guard let decodedData = try? decoder.decode(T.self, from: data) else { fatalError("Failed to decode \(file) from bundle!") }
        
        return decodedData
    }
}

