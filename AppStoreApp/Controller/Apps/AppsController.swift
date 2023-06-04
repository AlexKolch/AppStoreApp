//
//  AppsController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 24.05.2023.
//

import UIKit

class AppsController: BaseListController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellID"
    private let headerId = "headerID"

    fileprivate var appGroups = [AppGroup]()
    fileprivate var headerApps = [HeaderApp]()

    let activityView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)

        view.addSubview(activityView)
        activityView.fillSuperview()

        fetchData()
    }

    fileprivate func fetchData() {
        ///Синхронизация последовательных вызовов
        let dispatchGroup = DispatchGroup()

        var group1: AppGroup?
        var group2: AppGroup?

        dispatchGroup.enter()
        NetworkService.shared.fetchTopPaid { response, error in

            dispatchGroup.leave()
            group1 = response
        }
        dispatchGroup.enter()
        NetworkService.shared.fetchTopFree { response, error in
            dispatchGroup.leave()
            group2 = response
        }

        dispatchGroup.enter()
        NetworkService.shared.fetchHeaderApps { response, error in

            dispatchGroup.leave()

            self.headerApps = response ?? []
        }
        //Completion
        dispatchGroup.notify(queue: .main) {
            self.activityView.stopAnimating()
            print("Сompleted dispatch")
            if let group = group1 {
                self.appGroups.append(group)
            }
            if let group = group2 {
                self.appGroups.append(group)
            }
            self.collectionView.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsHeader
        header.appHorizontalController.headerApps = headerApps
        header.appHorizontalController.collectionView.reloadData()
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width - 32, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell

        let group = appGroups[indexPath.item]
        
        cell.titleLabel.text = group.feed.title
        cell.horizontalController.appGroup = group //передаем во вложенный контр. данные
        cell.horizontalController.collectionView.reloadData() //обязательно перезагружаем
        cell.horizontalController.didSelectHandler = { [weak self] result in

            let controller = AppDetailController(appId: result.id)
            controller.navigationItem.title = result.name
            self?.navigationController?.pushViewController(controller, animated: true)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
