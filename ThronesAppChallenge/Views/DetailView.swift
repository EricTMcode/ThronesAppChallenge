//
//  DetailView.swift
//  ThronesAppChallenge
//
//  Created by Eric on 02/05/2023.
//

import SwiftUI

struct DetailView: View {
    let house: House
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(house.name)
                .bold()
                .padding(.bottom)
            
            Text("Words:")
                .bold()
            
            if house.words == "" {
                Text("n/a")
                    .italic()
            } else {
                Text("\"\(house.words)\"")
                    .italic()
            }
            Spacer()
        }
        .font(.title)
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(house: House.example)
    }
}
