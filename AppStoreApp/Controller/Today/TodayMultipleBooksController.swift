//
//  TodayMultipleAppsController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 20.07.2023.
//

import UIKit

class TodayMultipleBooksController: BaseListController {

    enum Mode {
        case small, fullScreen
    }
    // MARK: - property
    let cellId = "CellID"
    var apps = [Result]()
    fileprivate let mode: Mode

    fileprivate let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()

    override var prefersStatusBarHidden: Bool {return true} ///скрыть статус бар

    // MARK: - INIT
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        if mode == .fullScreen {
            setupCloseButton()
        } else {
            collectionView.isScrollEnabled = false
        }

        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
    }

    // MARK: -  override func
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20 , left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }

    @objc func handleDismiss() {
       // dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return min(4, result.count)
        return apps.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        cell.apps = apps[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullScreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        return .zero
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = apps[indexPath.item].id
        let appDetailController = AppDetailController(appId: appId)
        present(appDetailController, animated: true)
       // navigationController?.pushViewController(appDetailController, animated: true)
    }

}
// MARK: -  extension
extension TodayMultipleBooksController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if mode == .fullScreen {
            return .init(width: view.frame.width - 48, height: 64)
        }
        return .init(width: view.frame.width, height: 64)
    }

}
