//
//  HomeCollectionViewModelContract.swift
//  Coco
//
//  Created by Jackie Leonardy on 04/07/25.
//

import Foundation

protocol HomeCollectionViewModelAction: AnyObject {
    func configureDataSource()
    func applySnapshot(_ snapshot: HomeCollectionViewSnapShot, completion: (() -> Void)?)
}

protocol HomeCollectionViewModelProtocol: AnyObject {
    var actionDelegate: HomeCollectionViewModelAction? { get set }
    
    func onViewDidLoad()
}
