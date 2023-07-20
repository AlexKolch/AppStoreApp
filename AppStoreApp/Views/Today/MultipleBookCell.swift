//
//  MultipleAppCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 20.07.2023.
//

import UIKit

class MultipleBookCell: UICollectionViewCell {

    var books: Result! {
        didSet {
            nameLabel.text = books.name
            companyLabel.text = books.artistName
            appIconView.sd_setImage(with: URL(string: books.artworkUrl100))
        }
    }

    let appIconView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
       
        appIconView.constrainWidth(constant: 64)
        appIconView.constrainHeight(constant: 64)

        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        getButton.layer.cornerRadius = 32 / 2
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        let stackView = UIStackView(arrangedSubviews: [appIconView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        stackView.spacing = 16
        stackView.alignment = .center

        addSubview(stackView)
        stackView.fillSuperview()

        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -4, right: 0), size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
