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
        var bookingStatus: String = data.status
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        if let targetDate: Date = formatter.date(from: data.activityDate) {
            let calendar: Calendar = Calendar.current
            let today: Date = Date()
            
            if targetDate < today {
                bookingStatus = "Completed"
            }
            else if targetDate > today {
                bookingStatus = "Upcoming"
            }
        }
        
        let dataModel: BookingDetailDataModel = BookingDetailDataModel(
            imageString: data.destination.imageUrl ?? "",
            activityName: data.activityTitle,
            packageName: data.packageName,
            location: data.destination.name,
            bookingDateText: data.activityDate,
            status: bookingStatus,
            paxNumber: data.participants,
            price: data.totalPrice,
            address: data.address
        )
        actionDelegate?.configureView(dataModel: dataModel)
    }
}
