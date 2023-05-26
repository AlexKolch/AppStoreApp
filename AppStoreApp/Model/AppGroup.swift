//
//  AppGroup.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 24.05.2023.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable  {
    let title: String
    let results: [Result]
}

struct Result: Decodable {
    let id, name, artistName, artworkUrl100: String
}
