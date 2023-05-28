//
//  ReviewCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 27.05.2023.
//

import UIKit

class ReviewCell: UICollectionViewCell {

    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let starLabel = UILabel(text: "Star", font: .systemFont(ofSize: 14))
    let bodyLabel = UILabel(text: "ReviewBody\nReviewBody\nReviewBody\nReviewBody\nReviewBody", font: .systemFont(ofSize: 16), numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true

        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLabel,
                                                                                            authorLabel], customSpacing: 8),
                                                            starLabel,
                                                            bodyLabel], spacing: 12)

        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        //titleLabel.setContentHuggingPriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
