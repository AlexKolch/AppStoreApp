//
//  AppsHeaderCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 24.05.2023.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {

    private let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    private let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 30))
    private let imageView = UIImageView(cornerRadius: 8)

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.backgroundColor = .red
        titleLabel.numberOfLines = 2
        companyLabel.textColor = .blue

        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
