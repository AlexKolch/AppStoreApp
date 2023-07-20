//
//  TodayMultipleAppsController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 20.07.2023.
//

import UIKit

class TodayMultipleBooksController: BaseListController {

    let cellId = "CellID"

    var result = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white

        collectionView.register(MultipleBookCell.self, forCellWithReuseIdentifier: cellId)

        NetworkService.shared.fetchBooks { AppGroup, Error in

            self.result = AppGroup?.feed.results ?? []

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return min(4, result.count)
        return result.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleBookCell
        cell.books = result[indexPath.item]
        return cell
    }
}

extension TodayMultipleBooksController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 64)
    }

}
