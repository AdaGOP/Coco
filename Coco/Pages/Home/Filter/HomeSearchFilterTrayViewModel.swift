//
//  HomeSearchFilterTrayViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 09/07/25.
//

import Combine
import Foundation
import SwiftUI

struct HomeSearchFilterTrayDataModel {
    var filterPillDataState: [HomeSearchFilterPillState] = []
    var priceRangeModel: HomeSearchFilterPriceRangeModel
    
    init(filterPillDataState: [HomeSearchFilterPillState], priceRangeModel: HomeSearchFilterPriceRangeModel) {
        self.filterPillDataState = filterPillDataState
        self.priceRangeModel = priceRangeModel
    }
}

final class HomeSearchFilterTrayViewModel: ObservableObject {
    let filterDidApplyPublisher: PassthroughSubject<HomeSearchFilterTrayDataModel, Never> = PassthroughSubject()
    
    @Published var dataModel: HomeSearchFilterTrayDataModel
    
    init(dataModel: HomeSearchFilterTrayDataModel) {
        self.dataModel = dataModel
    }
    
    func filterDidApply() {
        filterDidApplyPublisher.send(dataModel)
    }
}
