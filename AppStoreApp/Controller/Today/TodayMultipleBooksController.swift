//
//  TodayMultipleAppsController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 20.07.2023.
//

import UIKit

class TodayMultipleBooksController: BaseListController {

    let cellId = "CellID"
    var result = [Result]()
    fileprivate let mode: Mode

    fileprivate let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()

    @objc func handleDismiss() {
        dismiss(animated: true)
    }

    enum Mode {
        case small, fullScreen
    }

    init(mode: Mode) {
        self.mode = mode
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if mode == .fullScreen {
            setupCloseButton()
        } else {
            collectionView.isScrollEnabled = false
        }

        collectionView.backgroundColor = .white

        collectionView.register(MultipleBookCell.self, forCellWithReuseIdentifier: cellId)

    }

    override var prefersStatusBarHidden: Bool {return true}

    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20 , left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return min(4, result.count)
        return result.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleBookCell
        cell.books = result[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullScreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        return .zero
    }

}

extension TodayMultipleBooksController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if mode == .fullScreen {
            return .init(width: view.frame.width - 48, height: 64)
        }
        return .init(width: view.frame.width, height: 64)
    }

}
