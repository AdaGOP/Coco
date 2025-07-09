//
//  HomeSearchFilterTrayViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 09/07/25.
//

import Combine
import Foundation
import SwiftUI

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
