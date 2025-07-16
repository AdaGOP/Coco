//
//  MyTripViewModelContract.swift
//  Coco
//
//  Created by Jackie Leonardy on 14/07/25.
//

import Foundation

protocol MyTripViewModelDelegate: AnyObject {
    func notifyTripListDidTap(with data: BookingDetails)
}

protocol MyTripViewModelAction: AnyObject {
    func configureView(datas: [MyTripListCardDataModel])
}
protocol MyTripViewModelProtocol: AnyObject {
    var delegate: MyTripViewModelDelegate? { get set }
    var actionDelegate: MyTripViewModelAction? { get set }
    
    func onViewWillAppear()
    func onTripListDidTap(at index: Int)
}
