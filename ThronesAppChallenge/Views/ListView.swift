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
            List(housesVM.houses) { house in
                Text(house.name)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Houses of Westeros")
            .task {
                await housesVM.getData()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
