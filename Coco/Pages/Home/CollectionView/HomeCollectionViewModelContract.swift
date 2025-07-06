//
//  HomeCollectionViewModelContract.swift
//  Coco
//
//  Created by Jackie Leonardy on 04/07/25.
//

import Foundation

protocol HomeCollectionViewModelDelegate: AnyObject {
    func notifyCollectionViewActivityDidTap(_ dataModel: HomeActivityCellDataModel)
}

protocol HomeCollectionViewModelAction: AnyObject {
    func configureDataSource()
    func applySnapshot(_ snapshot: HomeCollectionViewSnapShot, completion: (() -> Void)?)
}

protocol HomeCollectionViewModelProtocol: AnyObject {
    var actionDelegate: HomeCollectionViewModelAction? { get set }
    var delegate: HomeCollectionViewModelDelegate? { get set }
    
    func onViewDidLoad()
    func updateActivity(activity: HomeActivityCellSectionDataModel)
    func onActivityDidTap(_ dataModel: HomeActivityCellDataModel)
}
