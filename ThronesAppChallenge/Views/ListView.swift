//
//  ListView.swift
//  ThronesAppChallenge
//
//  Created by Eric on 02/05/2023.
//

import SwiftUI

struct ListView: View {
    let houses = ["Targaryen", "Lannister", "Stark", "Martell", "Greyjoy"]
    
    var body: some View {
        NavigationStack {
            List(houses, id: \.self) { house in
                Text(house)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Houses of Westeros")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
