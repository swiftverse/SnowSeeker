//
//  Facility.swift
//  SnowSeeker
//
//  Created by Amit Shrivastava on 10/02/22.
//

import SwiftUI



struct Facility: Identifiable {
    let id = UUID()
    var name: String
    
    private let descriptions = [
        "Accommodation": "This resort has popular on-site accommodation.",
        "Beginners": "This resort has lots of ski schools.",
        "Cross-country": "This resort has many cross-country ski routes.",
        "Eco-friendly": "This resort has won an award for environmental friendliness.",
        "Family": "This resort is popular with families."
    ]
    
    private let icons = [
            "Accommodation": "house",
            "Beginners": "1.circle",
            "Cross-country": "map",
            "Eco-friendly": "leaf.arrow.circlepath",
            "Family": "person.3"
        ]
    //expose the above dictionary to SwitUI like below
    
    var icon: some View {
        
        Group {
            if let iconName = icons[name] {
                 Image(systemName: iconName)
                    .accessibilityLabel(name)
                    .foregroundColor(.secondary)
            } else {
              //  fatalError("Unknown facilty type \(name)")
                Text("\(name)")
               
            }
        }
        
        
    }
    
    var descriptin: String {
        if let message = descriptions[name] {
            return message
        } else {
            return "Working to find out"
          //  fatalError("Unknown facilty type: \(name)")
        }
    }

}
