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
    @Published var isLoading = false
    var urlString = "https://www.anapioficeandfire.com/api/houses?page=1&pageSize=50"
    
    var pageNumber = 1
    let pageSize = 50
    
    func getData() async {
        guard pageNumber != 0 else { return }
        urlString = "https://www.anapioficeandfire.com/api/houses?page=\(pageNumber)&pageSize=\(pageSize)"
        
        isLoading = true
        print("We are accessing the url \(urlString)")
        // Convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let houses = try? JSONDecoder().decode([House].self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data.")
                isLoading = false
                return
            }
            if houses.count < pageSize {
                pageNumber = 0
            } else {
                pageNumber += 1
            }
            self.houses += houses
            print("😎 JSON Returned! # of Houses: \(houses.count)")
            isLoading = false
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
            isLoading = false
        }
    }
    
    func loadNextIfNeeded(house: House) async {
        guard let lastHouse = houses.last else {
            return
        }
        if house.id == lastHouse.id && pageNumber != 0 {
            Task {
                await getData()
            }
        }
    }
    
    func loadAll() async {
        guard pageNumber != 0 else { return }
        await getData() // Get next page of data
        await loadAll() // Call loadAll again - Will stop when all pages are retrieved
    }
}
