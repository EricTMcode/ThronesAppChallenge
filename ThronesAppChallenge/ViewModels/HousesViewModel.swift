//
//  HousesViewModel.swift
//  ThronesAppChallenge
//
//  Created by Eric on 02/05/2023.
//

import Foundation

@MainActor
class HousesViewModel: ObservableObject {
    @Published var houses: [House] = []
    var urlString = "https://www.anapioficeandfire.com/api/houses?page=1&pageSize=50"
    
    func getData() async {
        print("We are accessing the url \(urlString)")
        // Convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
             // Try to decode JSON data into our own data structures
            do {
                self.houses = try JSONDecoder().decode([House].self, from: data)
                print("😎 JSON returned! # of Houses: \(self.houses.count)")
            } catch {
                print("😡 JSON ERROR: Could not decode returned JSON data")
            }
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
    
}
