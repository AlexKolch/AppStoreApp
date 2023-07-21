//
//  TodayMultipleAppCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 20.07.2023.
//

import UIKit

class TodayMultipleBookCell: BaseTodayCell {

    let multipleBooksController = TodayMultipleBooksController(mode: .small)

    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title

            multipleBooksController.result = todayItem.book
            multipleBooksController.collectionView.reloadData()
        }
    }

    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        layer.cornerRadius = 16

        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel,
                                                             titleLabel,
                                                             multipleBooksController.view], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
