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
                    LazyVStack(alignment: .leading) {
                        NavigationLink {
                            DetailView(house: house)
                        } label: {
                            Text(house.name)
                                .font(.title2)
                        }
                    }
                    .onAppear {
                        Task {
                            await housesVM.loadNextIfNeeded(house: house)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Houses of Westeros")
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("\(housesVM.houses.count) Houses Returned")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await housesVM.loadAll()
                            }
                        }
                    }
                }
                
                if housesVM.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.red)
                }
            }
        }
        .task {
            await housesVM.getData()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
