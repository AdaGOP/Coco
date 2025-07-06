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
    var tabIcon: UIImage? { UIImage(systemName: "bolt") }

    func makeRootViewController() -> UIViewController {
        let vc = UIHostingController(rootView: HomeLoadingView(state: vm))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            vm.percentage = 0.4
        })
        
        return vc
    }
    
    func getBaseCoordinator(navigationController: UINavigationController) -> BaseCoordinator {
        HomeCoordinator(navigationController: navigationController)
    }
    
    private let viewModel = HomeCollectionViewModel()
    
    private let vm = HomeLoadingState()
}
