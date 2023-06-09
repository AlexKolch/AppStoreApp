//
//  ReviewRowCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 27.05.2023.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {

    let reviewsRatingsLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))
    let reviewsController = ReviewsController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(reviewsRatingsLabel)
        addSubview(reviewsController.view)

        reviewsRatingsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))

        reviewsController.view.anchor(top: reviewsRatingsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
