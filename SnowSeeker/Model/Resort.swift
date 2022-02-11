//
//  Resort.swift
//  SnowSeeker
//
//  Created by Amit Shrivastava on 09/02/22.
//

import Foundation

struct Resort: Codable, Identifiable, Comparable {
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        lhs.name < rhs.name
    }
    
    
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    var faciltyTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let resorts: [Resort] = Bundle.main.decode("resorts.json")
    static let  example = resorts[0]
  
}
