//
//  HomeTabItem.swift
//  Coco
//
//  Created by Jackie Leonardy on 02/07/25.
//

import Foundation
import UIKit

struct HomeTabItem: TabItemRepresentable {
    var tabTitle: String { "Home" }
    var tabIcon: UIImage? { UIImage(systemName: "bolt") }

    func makeRootViewController() -> UIViewController {
        let vc = HomeViewController()
        vc.view.backgroundColor = .red
        vc.title = "Home"
        return vc
    }
    
    func getBaseCoordinator(navigationController: UINavigationController) -> BaseCoordinator {
        HomeCoordinator(navigationController: navigationController)
    }
}
