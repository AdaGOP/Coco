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
                imageUrlsString: [
                    "https://picsum.photos/id/237/600/341",
                    "https://picsum.photos/id/238/600/341",
                    "https://picsum.photos/id/239/600/341"
                ],
                detailInfomation: .init(
                    title: "Details",
                    content: "Explore the vibrant underwater world with our guided snorkeling tour. Discover colorful coral reefs and diverse marine life in a safe and fun environment. Perfect for all skill levels"
                ),
                providerDetail: .init(
                    title: "Trip Provider",
                    content: .init(
                        name: "Nusa Penida Eco Tour",
                        description: "EcoAdventures is dedicated to sustainable tourism and marine conservation. With over 10 years of experience, we offer unforgettable experiences while protecting our oceans",
                        imageUrlString: "https://picsum.photos/id/1/600/341"
                    )
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
                availablePackages: .init(
                    title: "Available Packages",
                    content: [
                        .init(
                            imageUrlString: "https://picsum.photos/id/237/600/341",
                            name: "Piazza del campo",
                            location: "italy",
                            rating: "4.4",
                            price: "$83"
                        ),
                        .init(
                            imageUrlString: "https://picsum.photos/id/237/600/341",
                            name: "Piazza del campo",
                            location: "italy",
                            rating: "4.4",
                            price: "$83"
                        ),
                        .init(
                            imageUrlString: "https://picsum.photos/id/237/600/341",
                            name: "Piazza del campo",
                            location: "italy",
                            rating: "4.4",
                            price: "$83"
                        )
                    ]
                )
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
