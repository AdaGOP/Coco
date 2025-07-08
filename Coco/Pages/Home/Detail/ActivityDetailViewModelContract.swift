//
//  ActivityDetailViewModelContract.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation

protocol ActivityDetailNavigationDelegate: AnyObject {
    func notifyActivityDetailPackageDidSelect(package: ActivityDetailDataModel.Package)
}

protocol ActivityDetailViewModelAction: AnyObject {
    func configureView(data: ActivityDetailDataModel)
    func updatePackageData(data: [ActivityDetailDataModel.Package])
}

protocol ActivityDetailViewModelProtocol: AnyObject {
    var actionDelegate: ActivityDetailViewModelAction? { get set }
    var navigationDelegate: ActivityDetailNavigationDelegate? { get set }
    
    func onViewDidLoad()
    func onPackageDidTap(data: ActivityDetailDataModel.Package)
    func onPackageDetailStateDidChange(shouldShowAll: Bool)
}
