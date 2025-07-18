//
//  TripDetailViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 17/07/25.
//

import Foundation

final class TripDetailViewModel {
    weak var actionDelegate: TripDetailViewModelAction?
    
    init(data: BookingDetails) {
        self.data = data
    }
    
    private let data: BookingDetails
}

extension TripDetailViewModel: TripDetailViewModelProtocol {
    func onViewDidLoad() {
        let dataModel: BookingDetailDataModel = BookingDetailDataModel(
            imageString: data.destination.imageUrl ?? "",
            activityName: data.activityTitle,
            packageName: data.packageName,
            location: data.destination.name,
            bookingDateText: data.activityDate,
            status: data.status,
            paxNumber: data.participants,
            price: data.totalPrice,
            address: data.address
        )
        actionDelegate?.configureView(dataModel: dataModel)
    }
}
