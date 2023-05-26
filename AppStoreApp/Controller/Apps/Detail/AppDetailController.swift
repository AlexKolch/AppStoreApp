//
//  AppDetailController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 26.05.2023.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    private let detailCellId = "detailCellId"
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
        collectionView.backgroundColor = .yellow

        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)

        navigationItem.largeTitleDisplayMode = .never
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell

        cell.nameLabel.text = app?.trackName
        cell.releaseNoteLabel.text = app?.releaseNotes
        cell.appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        cell.priceButton.setTitle(app?.formattedPrice, for: .normal)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
}

