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
    ///Конкретный Id приложения
    var appId: String! {
        didSet {
            print("here me app ID:", appId!)
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            NetworkService.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
                let app = result?.results.first
                self.app = app ///в структуру передаем конкретный объект по id
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    var app: Results? ///Cсылка на структуру данных

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)

        navigationItem.largeTitleDisplayMode = .never
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            cell.app = app ///присваиваем данные в переменную где происходит инициализация св-в
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.app = self.app
            return cell
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            //calculate size for cell/ расчитать размер ячейки в зависимости от размера контента
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))

            dummyCell.app = app
            dummyCell.layoutIfNeeded()

            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))

            return .init(width: view.frame.width, height: estimatedSize.height)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
}

