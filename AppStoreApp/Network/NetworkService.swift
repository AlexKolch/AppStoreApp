//
//  NetworkService.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 23.05.2023.
//

import Foundation

class NetworkService {
   static let shared = NetworkService()

    func fetchApps(searchTerm: String, completion: @escaping ([Results]?, Error?) -> ()) {
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

    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
         let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"

        fetchAppGroup(urlString: urlString, completion: completion)
    }

    func fetchTopPaid(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json"

        fetchAppGroup(urlString: urlString, completion: completion)
    }

    func fetchHeaderApps(completion: @escaping ([HeaderApp]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"

        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    //Helper
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
     fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    ///Generic JSON
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        print("T is type:", T.self)
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch let jsonError {
                completion(nil, jsonError)
            }
        }.resume()
    }
}
