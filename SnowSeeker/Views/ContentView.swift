//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Amit Shrivastava on 08/02/22.
//

import SwiftUI

enum SortingOrder {
    case byName
    case byCountry
    case normal
}

struct ContentView: View {
    @State private var searchText = ""
    @StateObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var showSortingData = false
    @State private var showFilterAlphabat = false
    @State private var showCountryAlphabat = false
    @State private var sortingData = SortingOrder.normal
    var body: some View {
        NavigationView {
            List(sortedResorts) {
                resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                    }
                    
                }
                    
                    
                }
              
                
            }
            .toolbar {
                Button {
                    showSortingData = true
                } label: {
                    Image(systemName: "arrow.up.arrow.down.circle")
                }
                
            }
            
            
            
            .confirmationDialog("Select Sort Type", isPresented: $showSortingData, actions: {
                Button("Sort by alphabat") {
                    sortingData = .byName
                }
                Button("Sort by country") {
                    sortingData = .byCountry
                }
            })
            
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            WelcomeView()
        }
        
        //.phoneOnlyStackNavigationView()
        .environmentObject(favorites)
    }
    
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        }
        else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var sortedResorts: [Resort] {

        switch sortingData {
        case .byName:
            return filteredResorts.sorted()
        case .normal:
            return filteredResorts
       
        case .byCountry:
            return filteredResorts.sorted { lhs, rhs in
                lhs.country < rhs.country
            }
        }
    }
    
  
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
