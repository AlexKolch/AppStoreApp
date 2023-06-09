//
//  TodayController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 05.06.2023.
//

import UIKit

class TodayController: BaseListController {
    private let cellId = "CellId"
    fileprivate var startingFrame: CGRect?
    private var appFullscreenController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appFullscreenController = AppFullScreenController()
        let redView = appFullscreenController.view!

        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        view.addSubview(redView)

        addChild(appFullscreenController)
        self.appFullscreenController = appFullscreenController

        guard let cell = collectionView.cellForItem(at: indexPath) else {return} ///Объект ячейки по индексу

        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        self.startingFrame = startingFrame

        redView.frame = startingFrame
        redView.layer.cornerRadius = 16

        ///Анимация открытия ячейки на весь экран
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {

            redView.frame = self.view.frame
            ///скрываем tabBar
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 50)
            self.tabBarController?.tabBar.isHidden = true
        }
    }

    @objc func handleRemoveRedView(gesture: UITapGestureRecognizer) {
        ///Анимация закрытия ячейки и возвращение к startingFrame
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {

            gesture.view?.frame = self.startingFrame ?? .zero
            ///возвращаем tabBar
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 70)
            self.tabBarController?.tabBar.isHidden = false
        } completion: { _ in
            gesture.view?.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
        }
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
