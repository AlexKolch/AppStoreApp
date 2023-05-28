//
//  ReviewRowCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 27.05.2023.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {

    let reviewsController = ReviewsController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
