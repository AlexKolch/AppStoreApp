//
//  TodayCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 05.06.2023.
//

import UIKit

class TodayCell: BaseTodayCell {

    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description

            backgroundColor = todayItem.backgroundColor
        }
    }

    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill

        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 200, height: 200))

        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 48, left: 24, bottom: 24, right: 24))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
