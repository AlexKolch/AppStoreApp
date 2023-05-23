//
//  AppsSearchController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 22.05.2023.
//

import UIKit


class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellID = "cellID"

    fileprivate var appResults = [Results]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white

        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellID)

        fetchITunesApps()
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    fileprivate func fetchITunesApps() {
        NetworkService.shared.fetchApps { results, error in
            
            if let error = error {
                print("Failed to fetch apps:", error)
                return
            }

            self.appResults = results ///get back our result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultsCell

        let appResult = appResults[indexPath.item]

        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
        
        return cell
    }

}
