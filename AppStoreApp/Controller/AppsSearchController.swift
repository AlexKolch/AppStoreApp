//
//  AppsSearchController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 22.05.2023.
//

import UIKit


class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

   fileprivate let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white

        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellID)
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
   
        return cell
    }

}
