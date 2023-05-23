//
//  SearchResultsCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 22.05.2023.
//

import UIKit

class SearchResultsCell: UICollectionViewCell {

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        return label
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()

    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16 
        return button
    }()

    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()

    func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel])

        let infoTopStackView = UIStackView(arrangedSubviews: [iconImageView, labelsStackView, getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center

        let screenshotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually

        let overAllStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenshotsStackView], spacing: 16)

        addSubview(overAllStackView)
        overAllStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16)) ///constraints
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
