//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Amit Shrivastava on 09/02/22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    @EnvironmentObject var favorites: Favorites
    @State  var selectedFacility: Facility?
    @State private var showingFacility = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topLeading) {
                    
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    Text("Image by: \(resort.imageCredit)")
                }
                HStack {
                    if sizeClass == .compact && typeSize > .large{
                        VStack(spacing: 10) {   ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                    ResortDetailsView(resort: resort)
                    SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
//                    Text(resort.facilities,format: .list(type: .and))
//                        .padding(.vertical)
                    HStack {
                        ForEach(resort.faciltyTypes) {facility in
                            
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                            facility.icon
                                .font(.title)
                            }
                        }
                    }
                }
                .padding(.horizontal)
               
            }
        }
        Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
            if favorites.contains(resort) {
                favorites.remove(resort)
            } else {
                favorites.add(resort)
            }
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More Information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
            
        } message: { facility in
            Text(facility.descriptin)
        }
        
        
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
            .environmentObject(Favorites())
    }
}
