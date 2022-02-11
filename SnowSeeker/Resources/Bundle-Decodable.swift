//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Amit Shrivastava on 09/02/22.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) for bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to load \(file) from bundle")
        }
        
        return loaded
    }
}
