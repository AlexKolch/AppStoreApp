//
//  TodayItem.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 19.07.2023.
//

import UIKit

struct TodayItem {

    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor

    let cellType: CellType

    enum CellType: String {
        case multiple, single 
    }
}
