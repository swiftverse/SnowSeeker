//
//  FileManager_Extension.swift
//  SnowSeeker
//
//  Created by Amit Shrivastava on 11/02/22.
//

import Foundation

extension FileManager {
    static var getDocumentsDirectory: URL {
        let paths = self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
