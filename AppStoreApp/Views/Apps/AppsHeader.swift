//
//  AppsHeader.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 24.05.2023.
//

import UIKit

class AppsHeader: UICollectionReusableView {

    let appHorizontalController = AppsHeaderHorizontalController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(appHorizontalController.view)
        appHorizontalController.view.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
