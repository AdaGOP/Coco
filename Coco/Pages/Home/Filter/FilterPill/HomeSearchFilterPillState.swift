//
//  HomeSearchFilterPillState.swift
//  Coco
//
//  Created by Jackie Leonardy on 09/07/25.
//

import Foundation

final class HomeSearchFilterPillState: ObservableObject {
    let title: String
    @Published var isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
