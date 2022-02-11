//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Amit Shrivastava on 11/02/22.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    let savePath = FileManager.getDocumentsDirectory.appendingPathComponent("saveKey")
    init() {
        //load
        if let data = try? Data(contentsOf: savePath) {
            if let favorites = try? JSONDecoder().decode(Set<String>.self, from: data) {
                        resorts = favorites
                        return
            }
        }
        resorts =  []
    }
    
    func remove() {
        
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
        
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(resorts) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
