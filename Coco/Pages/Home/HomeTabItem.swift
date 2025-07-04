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
        let vc = HomeCollectionViewController(viewModel: viewModel)
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 5.0,
            execute: {
                viewModel.updateActivity(
                    activity: (
                        title: "Most Popular",
                        dataModel: [
                            .init(
                                id: "1",
                                area: "Bunaken, Indonesia",
                                name: "Venice Grand Canal Cruise",
                                priceText: "Rp139.000",
                                imageUrl: URL(string: "https://picsum.photos/327/238")
                            ),
                            .init(
                                id: "2",
                                area: "Bunaken, Indonesia",
                                name: "Venice Grand Canal Cruise",
                                priceText: "Rp139.000",
                                imageUrl: URL(string: "https://picsum.photos/327/238")
                            )
                        ]
                    )
                )
        })
        
        return vc
    }
    
    func getBaseCoordinator(navigationController: UINavigationController) -> BaseCoordinator {
        HomeCoordinator(navigationController: navigationController)
    }
    
    private let viewModel = HomeCollectionViewModel()
}
