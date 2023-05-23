//
//  SearchResult.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 23.05.2023.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Results]
}

struct Results: Decodable {
    let trackName, primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
}
