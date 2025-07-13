//
//  HomeCoordinator.swift
//  Coco
//
//  Created by Jackie Leonardy on 01/07/25.
//

import Foundation
import UIKit

final class HomeCoordinator: BaseCoordinator {
    struct Input {
        let navigationController: UINavigationController
        let flow: Flow
        
        enum Flow {
            case activityDetail(data: ActivityDetailDataModel)
        }
    }
    
    init(input: Input) {
        self.input = input
        super.init(navigationController: input.navigationController)
    }
    
    override func start() {
        super.start()
        
        switch input.flow {
        case .activityDetail(let data):
            let detailViewModel = ActivityDetailViewModel(
                data: data
            )
            detailViewModel.navigationDelegate = self
            let detailViewController: ActivityDetailViewController = ActivityDetailViewController(viewModel: detailViewModel)
            start(viewController: detailViewController)
        }
    }
    
    private let input: Input
}

extension HomeCoordinator: HomeViewModelNavigationDelegate {
    func notifyHomeDidSelectActivity() {
        
    }
}

extension HomeCoordinator: HomeFormScheduleViewModelDelegate {
    func notifyFormScheduleDidNavigateToCheckout(with response: CreateBookingResponse) {
        let viewModel: CheckoutViewModel = CheckoutViewModel(
            bookingResponse: response.bookingDetails
        )
        viewModel.delegate = self
        let viewController = CheckoutViewController(viewModel: viewModel)
        start(viewController: viewController)
    }
}

extension HomeCoordinator: CheckoutViewModelDelegate {
    func notifyUserDidCheckout() {
        guard let tabBarController: BaseTabBarViewController = parentCoordinator?.navigationController?.tabBarController as? BaseTabBarViewController
        else {
            return
        }
        tabBarController.selectedIndex = 1
        navigationController?.popToRootViewController(animated: true)
    }
}

extension HomeCoordinator: ActivityDetailNavigationDelegate {
    func notifyActivityDetailPackageDidSelect(package: ActivityDetailDataModel, selectedPackageId: Int) {
//        let viewModel: HomeFormScheduleViewModel = HomeFormScheduleViewModel(
//            input: HomeFormScheduleViewModelInput(
//                package: package,
//                selectedPackageId: selectedPackageId
//            )
//        )
//        viewModel.delegate = self
//        let viewController: HomeFormScheduleViewController = HomeFormScheduleViewController(viewModel: viewModel)
//        start(viewController: viewController)
        
        let viewModel = CheckoutViewModel(
            bookingResponse: BookingDetails(
                status: "",
                bookingId: 1,
                startTime: "1232",
                destination: BookingDestination(
                    id: 1,
                    name: "Raja Ampat, West Papua",
                    imageUrl: nil,
                    description: "An archipelago of over 1,500 islands, famous for its world-class coral reef biodiversity and pristine marine life"
                ),
                totalPrice: 130000.0,
                packageName: "Group Package",
                participants: 2,
                activityDate: "2025-07-09",
                activityTitle: "Snorkeling in Piaynemo",
                bookingCreatedAt: "1231231"
            )
        )
        viewModel.delegate = self
        let viewController = CheckoutViewController(viewModel: viewModel)
        start(viewController: viewController)
    }
}
