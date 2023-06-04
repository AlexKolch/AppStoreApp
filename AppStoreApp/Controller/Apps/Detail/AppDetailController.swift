//
//  AppDetailController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 26.05.2023.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    private let detailCellId = "detailCellId"
    private let previewCellId = "previewCellId"
    private let reviewRowCellId = "reviewRowCell"
    fileprivate let appId: String

    // dependency injection constructor
    init(appId: String) {
        self.appId = appId
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var app: Results? ///Cсылка на структуру данных
    var reviews: Reviews?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewRowCellId)

        navigationItem.largeTitleDisplayMode = .never
        fetchData()
    }

    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"

        NetworkService.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
            let app = result?.results.first
            self.app = app ///в структуру передаем конкретный объект по id
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"

        NetworkService.shared.fetchGenericJSONData(urlString: reviewsUrl) { (reviews: Reviews?, error) in
            if let err = error {
                print("Failed", err)
                return
            }
            self.reviews = reviews
            // reviews?.feed.entry.forEach({print($0.rating.label)})
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            //reviews?.feed.title.label.forEach({ label in
            //print(label)
            //})
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            cell.app = app ///присваиваем данные в переменную где происходит инициализация св-в
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewRowCellId, for: indexPath) as! ReviewRowCell
            cell.reviewsController.reviews = self.reviews
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var height: CGFloat = 280

        if indexPath.item == 0 {
            //calculate size for cell/ расчитать размер ячейки в зависимости от размера контента
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))

            dummyCell.app = app
            dummyCell.layoutIfNeeded()

            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))

            height = estimatedSize.height
        } else if indexPath.item == 1 {
           height = 500
        } else {
           height = 280
        }
        return .init(width: view.frame.width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 16, right: 0)
    }
}

