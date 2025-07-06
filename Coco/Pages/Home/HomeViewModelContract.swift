//
//  HomeViewModelContract.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation

protocol HomeViewModelAction: AnyObject {
    func constructCollectionView(viewModel: some HomeCollectionViewModelProtocol)
    func constructLoadingState(state: HomeLoadingState)
    func toggleLoadingView(isShown: Bool, after: CGFloat)
}

protocol HomeViewModelProtocol: AnyObject {
    var actionDelegate: HomeViewModelAction? { get set }
    
    func onViewDidLoad()
}
