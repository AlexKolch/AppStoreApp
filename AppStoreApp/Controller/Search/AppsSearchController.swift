//
//  AppsSearchController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 22.05.2023.
//

import UIKit
import SDWebImage

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellID = "cellID"

    fileprivate var appResults = [Results]()
    private var timer: Timer?
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    private let enterSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.addSubview(enterSearchLabel)
        enterSearchLabel.fillSuperview(padding: .init(top: 100, left: 60, bottom: 0, right: 50))

        setupSearchBar()
      //  fetchITunesApps()
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }

//    fileprivate func fetchITunesApps() {
//        NetworkService.shared.fetchApps(searchTerm: "Twitter") { results, error in
//
//            if let error = error {
//                print("Failed to fetch apps:", error)
//                return
//            }
//
//            self.appResults = results ///get back our result
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchLabel.isHidden = appResults.count != 0
        return appResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultsCell

        cell.appResult = appResults[indexPath.item]
        
        return cell
    }
}

extension AppsSearchController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ///Delay before search
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            NetworkService.shared.fetchApps(searchTerm: searchText) { results, error in
                self.appResults = results ///get back our result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}
