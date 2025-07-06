//
//  HomeTabItem.swift
//  Coco
//
//  Created by Jackie Leonardy on 02/07/25.
//

import Foundation
import SwiftUI
import UIKit

struct HomeTabItem: TabItemRepresentable {
    var tabTitle: String { "Home" }
    var tabIcon: UIImage? { CocoIcon.icTabIconHome.image }

    func makeRootViewController() -> UIViewController {
        let viewModel: HomeViewModel = HomeViewModel()
        let viewController: HomeViewController = HomeViewController(viewModel: viewModel)
        
        return viewController
    }
    
    func getBaseCoordinator(navigationController: UINavigationController) -> BaseCoordinator {
        HomeCoordinator(navigationController: navigationController)
    }
    
    private let viewModel = HomeCollectionViewModel()
    
    private let vm = HomeLoadingState()
}
