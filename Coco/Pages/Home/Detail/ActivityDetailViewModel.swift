//
//  ActivityDetailViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation

final class ActivityDetailViewModel {
    weak var actionDelegate: ActivityDetailViewModelAction?
    weak var navigationDelegate: ActivityDetailNavigationDelegate?
    
    init(data: ActivityDetailDataModel) {
        self.data = data
    }
    
    private let data: ActivityDetailDataModel
}

extension ActivityDetailViewModel: ActivityDetailViewModelProtocol {
    func onViewDidLoad() {
        actionDelegate?.configureView(data: data)
    }
    
    func onPackageShowMoreDidTap() {
        actionDelegate?.updatePackageData(data: [])
    }
    
    func onPackageShowLessDidTap() {
        actionDelegate?.updatePackageData(data: [])
    }
    
    func onPackageDidTap(data: ActivityDetailDataModel.Package) {
        navigationDelegate?.notifyActivityDetailPackageDidSelect(package: data)
    }
}
