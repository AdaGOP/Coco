//
//  HomeCoordinator.swift
//  Coco
//
//  Created by Jackie Leonardy on 01/07/25.
//

import Foundation
import UIKit

final class HomeCoordinator: BaseCoordinator {
    override func start() {
        super.start()
        // start flow
        let detailViewModel = ActivityDetailViewModel(
            data: ActivityDetailDataModel(
                title: "Coral Reef Snorkeling Adventure",
                location: "Nusa Penida",
                imageUrlsString: [],
                detailInfomation: .init(
                    title: "Details",
                    content: "Explore the vibrant underwater world with our guided snorkeling tour. Discover colorful coral reefs and diverse marine life in a safe and fun environment. Perfect for all skill levels"
                ),
                providerDetail: .init(
                    title: "Trip Provider",
                    content: "2423423"
                ),
                tripFacilities: .init(
                    title: "This Trip Includes",
                    content: [
                        "Water bottle",
                        "Free Meal",
                        "Snorkeling Gear",
                        "Certified Guide",
                    ]
                ),
                tnc: .init(
                    title: "Terms and Condition",
                    content: [
                        "Rescheduleable"
                    ]
                ),
                availablePackages: [
                    
                ]
            )
        )
        detailViewModel.navigationDelegate = self
        let detailViewController: ActivityDetailViewController = ActivityDetailViewController(viewModel: detailViewModel)
        start(viewController: detailViewController)
    }
}

extension HomeCoordinator: HomeViewModelNavigationDelegate {
    func notifyHomeDidSelectActivity() {
        
    }
}

extension HomeCoordinator: ActivityDetailNavigationDelegate {
    func notifyActivityDetailPackageDidSelect(package: ActivityDetailDataModel.Package) {
        
    }
}
