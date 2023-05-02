//
//  ListView.swift
//  ThronesAppChallenge
//
//  Created by Eric on 02/05/2023.
//

import SwiftUI

struct ListView: View {
    @StateObject var housesVM = HousesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(housesVM.houses) { house in
                    Text(house.name)
                        .font(.title2)
                }
                .listStyle(.plain)
                .navigationTitle("Houses of Westeros")
                .task {
                    await housesVM.getData()
                }
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("\(housesVM.houses.count) Houses Returned")
                    }
                }
                
                if housesVM.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.red)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
