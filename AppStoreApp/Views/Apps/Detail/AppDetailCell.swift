//
//  AppDetailCell.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 26.05.2023.
//

import UIKit

class AppDetailCell: UICollectionViewCell {

    var app: Results! {
        didSet {
            nameLabel.text = app?.trackName
            releaseNoteLabel.text = app?.releaseNotes
            appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            priceButton.setTitle(app?.formattedPrice, for: .normal)
        }
    }

    let appIconImageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton = UIButton(title: "4.99$")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    let releaseNoteLabel = UILabel(text: "release Note", font: .systemFont(ofSize: 18), numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)

        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)

        priceButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 0.937254902, alpha: 1)
        priceButton.constrainHeight(constant: 32)
        priceButton.constrainWidth(constant: 80)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)


        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [appIconImageView,
                                           VerticalStackView(arrangedSubviews: [nameLabel, UIStackView(arrangedSubviews: [priceButton, UIView()]),
                                                                                UIView()
                                                                               ], spacing: 12)
                                          ], customSpacing: 20),
            whatsNewLabel,
            releaseNoteLabel
        ], spacing: 16)

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
