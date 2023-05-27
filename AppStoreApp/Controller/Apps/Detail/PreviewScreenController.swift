//
//  PreviewScreenController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 27.05.2023.
//

import UIKit

class PreviewScreenController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    private let cellId = "cellId"

    var app: Results? {
        didSet {
            collectionView.reloadData()
        }
    }

    class ScreenshotCell: UICollectionViewCell {
        let imageView = UIImageView(cornerRadius: 12)

        override init(frame: CGRect) {
            super.init(frame: frame)
           
            addSubview(imageView)
            imageView.fillSuperview()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell

        let screenshotUrl = self.app?.screenshotUrls[indexPath.item]
        guard let screenshotUrl = screenshotUrl else {return UICollectionViewCell()}

        cell.imageView.sd_setImage(with: URL(string: screenshotUrl))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
