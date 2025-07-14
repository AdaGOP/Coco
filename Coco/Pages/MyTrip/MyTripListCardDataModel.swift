//
//  MyTripListCardDataModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 14/07/25.
//

import Foundation

struct MyTripListCardDataModel {
    let statusLabel: StatusLabel
    let imageUrl: String
    let dateText: String
    let title: String
    let location: String
    let totalPax: Int
    let price: String
    
    struct StatusLabel {
        let text: String
        let style: CocoStatusLabelStyle
    }
    
    init(bookingDetail: BookingDetails) {
        statusLabel = StatusLabel(text: bookingDetail.status, style: .unpaid) // TODO: BE Map based on enum
        imageUrl = bookingDetail.destination.imageUrl ?? ""
        dateText = bookingDetail.activityDate
        title = bookingDetail.activityTitle
        location = bookingDetail.destination.name
        totalPax = bookingDetail.participants
        price = "Rp \(bookingDetail.totalPrice)"
    }
}
