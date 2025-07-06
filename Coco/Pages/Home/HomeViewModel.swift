//
//  HomeViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation

final class HomeViewModel {
    weak var actionDelegate: (any HomeViewModelAction)?
    
    init(activityFetcher: ActivityFetcherProtocol = ActivityFetcher()) {
        self.activityFetcher = activityFetcher
    }
    
    private let activityFetcher: ActivityFetcherProtocol
    private lazy var collectionViewModel: HomeCollectionViewModelProtocol = {
        let viewModel: HomeCollectionViewModel = HomeCollectionViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    private lazy var loadingState: HomeLoadingState = HomeLoadingState()
}

extension HomeViewModel: HomeViewModelProtocol {
    func onViewDidLoad() {
        actionDelegate?.constructCollectionView(viewModel: collectionViewModel)
        actionDelegate?.constructLoadingState(state: loadingState)
        
        activityFetcher.fetchActivity(endpoint: .all) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.loadingState.percentage = 100
                    self.actionDelegate?.toggleLoadingView(isShown: false, after: 1.0)
                }
                
                let sectionData: [HomeActivityCellDataModel] = response.values.map { HomeActivityCellDataModel(activity: $0) }
                collectionViewModel.updateActivity(activity: (title: "", dataModel: sectionData))
            case .failure(let failure):
                break
            }
        }
    }
}

extension HomeViewModel: HomeCollectionViewModelDelegate {
    func notifyCollectionViewActivityDidTap(_ dataModel: HomeActivityCellDataModel) {
        // wiring to detail
    }
}
