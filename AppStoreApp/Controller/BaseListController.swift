//
//  BaseListController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 24.05.2023.
//

import UIKit

class BaseListController: UICollectionViewController {

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


}
