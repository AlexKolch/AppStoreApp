//
//  TodayController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 05.06.2023.
//

import UIKit

class TodayController: BaseListController {
    static let cellSize: CGFloat = 500
    var appFullscreenController: AppFullScreenController!

    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?

    fileprivate var startingFrame: CGRect?

    var items = [TodayItem]() ///здесь будут наши значения ячеек

    let activityIndecator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        view.addSubview(activityIndecator)
        activityIndecator.centerInSuperview()

        fetchData()

        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleBookCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 24, right: 0)
    }

    fileprivate func fetchData() {
//DispatchGroup for next cells
        let dispatchGroup = DispatchGroup()
        var fetchedBooks: AppGroup? ///записываем сюда ответ от сервера

        dispatchGroup.enter()
        NetworkService.shared.fetchBooks { appGroup, error in
            if let error = error {
                print("Failed to fetch books:", error)
            }
          
            fetchedBooks = appGroup
            dispatchGroup.leave()
        }

        //completion block
        dispatchGroup.notify(queue: .main) {
            //I'll have access to books
            self.activityIndecator.stopAnimating()
            
            self.items = [
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, book: []),
                
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, book: []),

                TodayItem.init(category: "TODAY BOOKS", title: fetchedBooks?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, book: fetchedBooks?.feed.results ?? [])
            ]
            self.collectionView.reloadData()
        }
    }

    // MARK: - func collectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellId = items[indexPath.item].cellType.rawValue

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item] ///инициализируем св-во значений значениями из массива установленных объектов!

        //multiple app cell
//        if indexPath.item == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleAppCellId, for: indexPath) as! TodayMultipleAppCell
//            cell.todayItem = items[indexPath.item]
//            return cell
//        }
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
//        cell.todayItem = items[indexPath.item]

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if items[indexPath.item].cellType == .multiple {
            let fullController = TodayMultipleBooksController(mode: .fullScreen)
            fullController.result = items[indexPath.item].book
            fullController.modalPresentationStyle = .fullScreen
            present(fullController, animated: true)
        }

        guard items[indexPath.item].cellType == .single else {return}

        let appFullscreenController = AppFullScreenController()
        appFullscreenController.todayItem = items[indexPath.item]
        appFullscreenController.dismissHandler = {
            self.handleRemoveRedView()
        }

        let fullScreenView = appFullscreenController.view!
        fullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        view.addSubview(fullScreenView)

        addChild(appFullscreenController)

        self.appFullscreenController = appFullscreenController

        self.collectionView.isUserInteractionEnabled = false

        guard let cell = collectionView.cellForItem(at: indexPath) else {return} ///Объект ячейки по индексу

        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}

        self.startingFrame = startingFrame

        ///auto layout constraint animations
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()

        fullScreenView.layer.cornerRadius = 16

        ///Анимация открытия ячейки на весь экран
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()

            ///скрываем tabBar
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 50)
            self.tabBarController?.tabBar.isHidden = true
        }, completion: nil)
    }

   @objc func handleRemoveRedView() {
        ///Анимация закрытия ячейки и возвращение к startingFrame
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

//            self.appFullscreenController.tableView.contentOffset = .zero
            self.appFullscreenController.tableView.scrollToRow(at: [0, 0], at: .top, animated: true) ///второй способ свернуть

            guard let startingFrame = self.startingFrame else {return}

            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height

            self.view.layoutIfNeeded()
            ///возвращаем tabBar
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 70)
            self.tabBarController?.tabBar.isHidden = false
        }, completion: { _ in
            self.appFullscreenController.view.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}
// MARK: - extension
extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
