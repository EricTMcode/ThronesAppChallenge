//
//  House.swift
//  ThronesAppChallenge
//
//  Created by Eric on 02/05/2023.
//

import Foundation

struct House: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String
    var words: String
    
    enum CodingKeys: CodingKey {
        case name, url, words
    }
}
