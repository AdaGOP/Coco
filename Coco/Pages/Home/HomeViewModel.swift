//
//  HomeViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation

final class HomeViewModel {
    weak var actionDelegate: (any HomeViewModelAction)?
    weak var navigationDelegate: (any HomeViewModelNavigationDelegate)?
    
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
    private lazy var searchBarViewModel: HomeSearchBarViewModel = HomeSearchBarViewModel(
        currentTypedText: "",
        trailingIcon: (image: CocoIcon.icFilterIcon.image, didTap: { [weak self] in
            self?.actionDelegate?.openFilterTray()
        }),
        isTypeAble: false,
        delegate: self
    )
    
    private var responseMap: [Int: Activity] = [:]
}

extension HomeViewModel: HomeViewModelProtocol {
    func onViewDidLoad() {
        actionDelegate?.constructCollectionView(viewModel: collectionViewModel)
        actionDelegate?.constructLoadingState(state: loadingState)
        actionDelegate?.constructNavBar(viewModel: searchBarViewModel)
        
        fetch()
    }
}

extension HomeViewModel: HomeCollectionViewModelDelegate {
    func notifyCollectionViewActivityDidTap(_ dataModel: HomeActivityCellDataModel) {
        guard let activity: Activity = responseMap[dataModel.id] else { return }
        let data: ActivityDetailDataModel = ActivityDetailDataModel(activity)
        actionDelegate?.activityDidSelect(data: data)
    }
}

extension HomeViewModel: HomeSearchBarViewModelDelegate {
    func notifyHomeSearchBarDidTap(isTypeAble: Bool) {
        guard !isTypeAble else { return }
        
        actionDelegate?.openSearchTray()
    }
}

private extension HomeViewModel {
    func fetch() {
        activityFetcher.fetchActivity(
            request: ActivitySearchRequest(pSearchText: searchBarViewModel.currentTypedText),
            endpoint: .all
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.loadingState.percentage = 100
                    self.actionDelegate?.toggleLoadingView(isShown: false, after: 1.0)
                }
                
                var sectionData: [HomeActivityCellDataModel] = []
                response.values.forEach {
                    sectionData.append(HomeActivityCellDataModel(activity: $0))
                    self.responseMap[$0.id] = $0
                }
                collectionViewModel.updateActivity(activity: (title: "", dataModel: sectionData))
            case .failure(let failure):
                break
            }
        }
    }
}
