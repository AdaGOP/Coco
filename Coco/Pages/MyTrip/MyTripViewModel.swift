//
//  MyTripViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 14/07/25.
//

import Foundation

final class MyTripViewModel {
    weak var delegate: (any MyTripViewModelDelegate)?
    weak var actionDelegate: (any MyTripViewModelAction)?
    
    init(fetcher: MyTripBookingListFetcherProtocol = MyTripBookingListFetcher()) {
        self.fetcher = fetcher
    }
    
    private let fetcher: MyTripBookingListFetcherProtocol
    private var responses: [CreateBookingResponse] = []
}

extension MyTripViewModel: MyTripViewModelProtocol {
    func onViewDidLoad() {
        Task {
            let response: [CreateBookingResponse] = try await fetcher.fetchTripBookingList(
                request: TripBookingListSpec(userId: UserDefaults.standard.value(forKey: "user-id") as? String ?? "")
            ).values
            
            responses = response
            
            actionDelegate?.configureView(datas: response.map({ listData in
                MyTripListCardDataModel(bookingDetail: listData.bookingDetails)
            }))
        }
    }
    
    func onTripListDidTap(at index: Int) {
        guard index < responses.count else { return }
        delegate?.notifyTripListDidTap(with: responses[index])
    }
}
