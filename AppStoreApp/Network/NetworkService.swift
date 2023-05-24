//
//  NetworkService.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 23.05.2023.
//

import Foundation

class NetworkService {
   static let shared = NetworkService()

    func fetchApps(searchTerm: String, completion: @escaping ([Results], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"

        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch apps:", error)
                completion([], nil)
            }

            guard let data = data else {return}
            // print(String(data: data, encoding: .utf8) ?? "")
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                // searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
                completion(searchResult.results, nil)

            } catch let jsonError {
                print("Failed to decode json:", jsonError)
                completion([], jsonError)
            }
        }.resume()
    }

    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json") else {return}

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)

                appGroup.feed.results.forEach({print($0.name)})
                completion(appGroup, nil)
            } catch let jsonError {
               // print( print("Failed to decode json:", jsonError))
                completion(nil, jsonError)
            }
        }.resume()
    }
}
